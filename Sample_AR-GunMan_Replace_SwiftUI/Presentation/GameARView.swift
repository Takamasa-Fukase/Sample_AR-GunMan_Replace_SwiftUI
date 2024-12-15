//
//  GameARView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI
import ARKit

struct GameARViewContainer: UIViewRepresentable {
    private let arController: GameARControllerInterface
    
    init(arController: GameARControllerInterface) {
        self.arController = arController
    }
    
    func makeUIView(context: Context) -> some UIView {
        return arController.getSceneView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

protocol GameARControllerInterface {
    var targetHit: (() -> Void)? { get set }
    func getSceneView() -> UIView
    func setup(targetCount: Int)
    func runSession()
    func pauseSession()
    func showWeaponObject(objectData: WeaponObjectData)
    func renderWeaponFiring()
    func changeTargetsAppearance(to imageName: String)
}

final class GameARController: NSObject {
    var targetHit: (() -> Void)?
    private var sceneView: ARSCNView
    private var loadedWeaponDataList: [LoadedWeaponObjectData] = []
    private let originalBulletNode = SceneNodeUtil.originalBulletNode()
    private var currentWeaponId: Int = 0
    
    init(frame: CGRect) {
        // MEMO: 予めframeを渡して初期化することで、モーダル出現アニメーションの途中時点から既に正しい比率でSceneオブジェクトを表示した状態で一緒にアニメーションさせられるので遷移の見た目が綺麗になる（遷移前に予め表示予定領域のframeが確定している場合）
        sceneView = ARSCNView(frame: frame)
        super.init()
        setup(targetCount: 50)
    }
    
    private func showTargetsToRandomPositions(count: Int) {
        let originalTargetNode = SceneNodeUtil.originalTargetNode()
        
        DispatchQueue.main.async { [weak self] in
            Array(0..<count).forEach { _ in
                let clonedTargetNode = originalTargetNode.clone()
                clonedTargetNode.position = SceneNodeUtil.getRandomTargetPosition()
                SceneNodeUtil.addBillboardConstraint(clonedTargetNode)
                self?.sceneView.scene.rootNode.addChildNode(clonedTargetNode)
            }
        }
    }
    
    private func createWeaponNode(scnFilePath: String, nodeName: String) -> SCNNode {
        let weaponParentNode = SceneNodeUtil.loadScnFile(of: scnFilePath, nodeName: nodeName)
        SceneNodeUtil.addBillboardConstraint(weaponParentNode)
        weaponParentNode.position = SceneNodeUtil.getCameraPosition(sceneView)
        return weaponParentNode
    }
    
    private func removeOtherWeapons(except weaponId: Int) {
        loadedWeaponDataList.forEach { loadedWeaponData in
            if loadedWeaponData.objectData.weaponId != weaponId {
                loadedWeaponData.weaponParentNode.removeFromParentNode()
            }
        }
    }
    
    private func currentWeaponObjectData() -> LoadedWeaponObjectData? {
        return loadedWeaponDataList.first(where: { $0.objectData.weaponId == currentWeaponId })
    }
    
    private func currentWeaponNode() -> SCNNode {
        guard let currentObjectData = loadedWeaponDataList.first(where: { $0.objectData.weaponId == currentWeaponId }) else { return SCNNode() }
        return currentObjectData.weaponParentNode.childNode(withName: currentObjectData.objectData.weaponObjectName, recursively: false) ?? SCNNode()
    }
    
    private func renderTargetHitParticle(to position: SCNVector3) {
        if let particleNode = currentWeaponObjectData()?.particleNode {
            let clonedParticleNode = particleNode.clone()
            clonedParticleNode.position = position
            clonedParticleNode.particleSystems?.first?.birthRate = 300
            clonedParticleNode.particleSystems?.first?.loops = false
            sceneView.scene.rootNode.addChildNode(clonedParticleNode)
        }
    }
}

extension GameARController: GameARControllerInterface {
    func getSceneView() -> UIView {
        return sceneView
    }
    
    func setup(targetCount: Int) {
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        
        showTargetsToRandomPositions(count: targetCount)
    }
    
    func runSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    func pauseSession() {
        sceneView.session.pause()
    }
    
    func showWeaponObject(objectData: WeaponObjectData) {
        currentWeaponId = objectData.weaponId
        removeOtherWeapons(except: objectData.weaponId)
        
        if let loadedWeaponData = loadedWeaponDataList.first(where: { $0.objectData.weaponId == objectData.weaponId }) {
            sceneView.scene.rootNode.addChildNode(loadedWeaponData.weaponParentNode)
        }else {
            let weaponParentNode = createWeaponNode(scnFilePath: objectData.objectFilePath, nodeName: objectData.rootObjectName)
            
            // Particle情報がある場合はロード
            let particleNode: SCNNode? = {
                if let particleFilePath = objectData.targetHitParticleFilePath,
                   let particleNodeName = objectData.targetHitParticleRootObjectName {
                    let particleNode = SceneNodeUtil.loadScnFile(of: particleFilePath, nodeName: particleNodeName)
                    particleNode.particleSystems?.first?.birthRate = 0
                    return particleNode
                }else {
                    return nil
                }
            }()
            
            // 武器を持つ手の揺れのアニメーションが有効な場合は描画
            if objectData.isGunnerHandShakingAnimationEnabled {
                let weaponNode = weaponParentNode.childNode(withName: objectData.weaponObjectName, recursively: false) ?? SCNNode()
                weaponNode.runAction(SceneAnimationUtil.gunnerHandShakingAnimation)
            }
            
            let loadedWeaponData = LoadedWeaponObjectData(
                objectData: objectData,
                weaponParentNode: weaponParentNode,
                particleNode: particleNode
            )
            loadedWeaponDataList.append(loadedWeaponData)
            sceneView.scene.rootNode.addChildNode(loadedWeaponData.weaponParentNode)
        }
    }
    
    func renderWeaponFiring() {
        // 弾の発射アニメーションを描画
        let clonedBulletNode = originalBulletNode.clone()
        clonedBulletNode.position = SceneNodeUtil.getCameraPosition(sceneView)
        sceneView.scene.rootNode.addChildNode(clonedBulletNode)
        clonedBulletNode.runAction(SceneAnimationUtil.bulletShootingAnimation(sceneView.pointOfView)) {
            clonedBulletNode.removeFromParentNode()
        }
        
        // 武器の反動アニメーションを描画
        if currentWeaponObjectData()?.objectData.isRecoilAnimationEnabled ?? false {
            currentWeaponNode().runAction(SceneAnimationUtil.recoilAnimation)
        }
    }
    
    func changeTargetsAppearance(to imageName: String) {
        sceneView.scene.rootNode.childNodes.forEach({ node in
            if node.name == "target" {
                while node.childNode(withName: "torus", recursively: false) != nil {
                    //ドーナツ型の白い線のパーツを削除
                    node.childNode(withName: "torus", recursively: false)?.removeFromParentNode()
                }
            }
            node.childNode(withName: "sphere", recursively: false)?
                .geometry?.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        })
    }
}

extension GameARController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        currentWeaponObjectData()?.weaponParentNode.position = SceneNodeUtil.getCameraPosition(sceneView)
    }
}

extension GameARController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        if contact.nodeA.name == "target" && contact.nodeB.name == "bullet"
            || contact.nodeB.name == "target" && contact.nodeA.name == "bullet" {
            targetHit?()
            
            renderTargetHitParticle(to: contact.contactPoint)
            
            contact.nodeA.removeFromParentNode()
            contact.nodeB.removeFromParentNode()
        }
    }
}
