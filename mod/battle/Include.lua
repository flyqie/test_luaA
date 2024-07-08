﻿require("Mod/Battle/BattleState")
require("Mod/Battle/BattleEvent")
require("Mod/Battle/BattleUnitEvent")
require("Mod/Battle/BattleBulletEvent")
require("Mod/Battle/BattleBuffEvent")
require("Mod/Battle/BattleCardPuzzleEvent")
require("Mod/Battle/Data/BattleConst")
require("Mod/Battle/Data/BattleConfig")
require("Mod/Battle/Data/BattleCardPuzzleConfig")
require("Mod/Battle/Data/BattleAttr")
require("Mod/Battle/Command/gate/BattleGatePrologue")
require("Mod/Battle/Command/gate/BattleGateDebug")
require("Mod/Battle/Command/gate/BattleGateSubmarine")
require("Mod/Battle/Command/gate/BattleGateDodgem")
require("Mod/Battle/Command/gate/BattleGateSimulation")
require("Mod/Battle/Command/gate/BattleGatePerform")
require("Mod/Battle/Command/gate/BattleGateScenario")
require("Mod/Battle/Command/gate/BattleGateChallenge")
require("Mod/Battle/Command/gate/BattleGateLimitChallenge")
require("Mod/Battle/Command/gate/BattleGateWorld")
require("Mod/Battle/Command/gate/BattleGateCooperate")
require("Mod/Battle/Command/gate/BattleGateRoutine")
require("Mod/Battle/Command/gate/BattleGateDuel")
require("Mod/Battle/Command/gate/BattleGateSubRoutine")
require("Mod/Battle/Command/gate/BattleGateActBoss")
require("Mod/Battle/Command/gate/BattleGateActBossSP")
require("Mod/Battle/Command/gate/BattleGateHPShareActBoss")
require("Mod/Battle/Command/gate/BattleGateBossExperiment")
require("Mod/Battle/Command/gate/BattleGateTest")
require("Mod/Battle/Command/gate/BattleGateWorldBoss")
require("Mod/Battle/Command/gate/BattleGateRewardPerform")
require("Mod/Battle/Command/gate/BattleGateGuild")
require("Mod/Battle/Command/gate/BattleGateBossRush")
require("Mod/Battle/Command/gate/BattleGateBossRushEX")
require("Mod/Battle/Command/gate/BattleGateCardPuzzle")
require("Mod/Battle/Command/gate/BattleGate")
require("Mod/Battle/Command/BattleCommand")
require("Mod/Battle/Command/BattleSingleDungeonCommand")
require("Mod/Battle/Command/BattleSingleChallengeCommand")
require("Mod/Battle/Command/BattleControllerCommand")
require("Mod/Battle/Command/BattleControllerWeaponCommand")
require("Mod/Battle/Command/BattleDuelArenaCommand")
require("Mod/Battle/Command/BattleSimulationCommand")
require("Mod/Battle/Command/BattleDodgemCommand")
require("Mod/Battle/Command/BattleInheritDungeonCommand")
require("Mod/Battle/Command/BattleSubmarineRunCommand")
require("Mod/Battle/Command/BattleSubRoutineCommand")
require("Mod/Battle/Command/BattleDebugCommand")
require("Mod/Battle/Command/BattleWorldBossCommand")
require("Mod/Battle/Command/BattleGuildBossCommand")
require("Mod/Battle/Command/BattleCardPuzzleCommand")
require("Mod/Battle/Data/BattleVariable")
require("Mod/Battle/Data/BattleFormulas")
require("Mod/Battle/Data/BattleCardPuzzleFormulas")
require("Mod/Battle/Data/BattleDataFunction")
require("Mod/Battle/Data/BattleTargetChoise")
require("Mod/Battle/Data/BattleUnitDataFunction")
require("Mod/Battle/Data/BattleBulletDataFunction")
require("Mod/Battle/Data/Wave/BattleWaveInfo")
require("Mod/Battle/Data/Wave/BattleAidWave")
require("Mod/Battle/Data/Wave/BattleSpawnWave")
require("Mod/Battle/Data/Wave/BattleStoryWave")
require("Mod/Battle/Data/Wave/BattleDelayWave")
require("Mod/Battle/Data/Wave/BattleRangeWave")
require("Mod/Battle/Data/Wave/BattleSwitchBGMWave")
require("Mod/Battle/Data/Wave/BattleGuideWave")
require("Mod/Battle/Data/Wave/BattleCameraWave")
require("Mod/Battle/Data/Wave/BattleClearWave")
require("Mod/Battle/Data/Wave/BattleEnvironmentWave")
require("Mod/Battle/Data/Wave/BattleLabelWave")
require("Mod/Battle/Data/Wave/BattleCardPuzzleWave")
require("Mod/Battle/Data/Manager/BattleWaveUpdater")
require("Mod/Battle/Data/BattleDataProxy")
require("Mod/Battle/Data/BattleDataProxyLogic")
require("Mod/Battle/Data/BattleDataProxyStatistics")
require("Mod/Battle/Data/BattleDataProxyDebug")
require("Mod/Battle/Data/VO/BattlePlayerWeaponVO")
require("Mod/Battle/Data/VO/BattleAntiAirWeaponVO")
require("Mod/Battle/Data/VO/BattleChargeWeaponVO")
require("Mod/Battle/Data/VO/BattleTorpedoWeaponVO")
require("Mod/Battle/Data/VO/BattleAllInStrikeVO")
require("Mod/Battle/Data/VO/BattleSubmarineAidVO")
require("Mod/Battle/Data/VO/BattleFleetMotionVO")
require("Mod/Battle/Data/VO/BattleSubmarineFuncVO")
require("Mod/Battle/Data/VO/BattleCldSystem")
require("Mod/Battle/Data/VO/BattleDrops")
require("Mod/Battle/Data/VO/BattleFleetVO")
require("Mod/Battle/Data/VO/BattleTeamVO")
require("Mod/Battle/Data/VO/BattleManualWeaponAutoBot")
require("Mod/Battle/Data/VO/BattleUnitPhaseSwitcher")
require("Mod/Battle/Data/VO/BattleUnitCloakComponent")
require("Mod/Battle/Data/VO/BattleUnitAimBiasComponent")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleComponent")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleEnergy")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleCardManageComponent")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleHand")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleDeck")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleDiscard")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleMoveDeck")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleAttribute")
require("Mod/Battle/Data/VO/BattleFleetCardPuzzleFleetBuffManager")
require("Mod/Battle/Data/VO/BattleCardPuzzleCard")
require("Mod/Battle/Data/VO/BattleCardPuzzleCardEffectQueue")
require("Mod/Battle/Data/VO/BattleJoyStickAutoBot")
require("Mod/Battle/Data/VO/Strategy/BattleJoyStickBotBaseStrategy")
require("Mod/Battle/Data/VO/Strategy/RandomStrategy")
require("Mod/Battle/Data/VO/Strategy/CounterMainRandomStrategy")
require("Mod/Battle/Data/VO/Strategy/AutoPilotStrategy")
require("Mod/Battle/Data/Component/Move")
require("Mod/Battle/Data/Component/BattleCldComponent")
require("Mod/Battle/Data/Component/BattleColumnCldComponent")
require("Mod/Battle/Data/Component/BattleCubeCldComponent")
require("Mod/Battle/Data/Component/BattleFleetBound")
require("Mod/Battle/Data/Component/WeaponQueue")
require("Mod/Battle/Data/Component/ManualWeaponQueue")
require("Mod/Battle/Data/Component/BattleFleetAttrComponent")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilot")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/IPilot")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotMove")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotStay")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotMoveTo")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotBrownian")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotRelativeBrownian")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotCircle")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotHiveRelativeStay")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotHiveRelativeCircle")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotRelativeFleetMoveTo")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotMoveRelative")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotMinionRelativeStay")
require("Mod/Battle/Data/Unit/AutoPilotStateMachine/AutoPilotMinionRelativeCircle")
require("Mod/Battle/Data/Unit/UnitStateMachine/IUnitState")
require("Mod/Battle/Data/Unit/UnitStateMachine/UnitState")
require("Mod/Battle/Data/Unit/UnitStateMachine/IdleState")
require("Mod/Battle/Data/Unit/UnitStateMachine/MoveState")
require("Mod/Battle/Data/Unit/UnitStateMachine/AttackState")
require("Mod/Battle/Data/Unit/UnitStateMachine/AttackLeftState")
require("Mod/Battle/Data/Unit/UnitStateMachine/DeadState")
require("Mod/Battle/Data/Unit/UnitStateMachine/MoveLeftState")
require("Mod/Battle/Data/Unit/UnitStateMachine/SkillState")
require("Mod/Battle/Data/Unit/UnitStateMachine/VictoryState")
require("Mod/Battle/Data/Unit/UnitStateMachine/VictorySwimState")
require("Mod/Battle/Data/Unit/UnitStateMachine/StandState")
require("Mod/Battle/Data/Unit/UnitStateMachine/SpellState")
require("Mod/Battle/Data/Unit/UnitStateMachine/DivingState")
require("Mod/Battle/Data/Unit/UnitStateMachine/DiveState")
require("Mod/Battle/Data/Unit/UnitStateMachine/DiveLeftState")
require("Mod/Battle/Data/Unit/UnitStateMachine/RaidState")
require("Mod/Battle/Data/Unit/UnitStateMachine/RaidLeftState")
require("Mod/Battle/Data/Unit/UnitStateMachine/InterruptState")
require("Mod/Battle/Data/Unit/UnitStateMachine/SkillStartState")
require("Mod/Battle/Data/Unit/UnitStateMachine/SkillEndState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/IOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/OxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/DiveOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/FloatOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/IdleOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/RaidOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/FreeDiveOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/FreeFloatOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/FreeBenchOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/DeepMineOxyState")
require("Mod/Battle/Data/Unit/OxygenStateMachine/RetreatOxyState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/IAntiSubState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/AntiSubState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/CalmAntiSubState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/EngageAntiSubState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/SuspiciousAntiSubState")
require("Mod/Battle/Data/Unit/AntiSubStateMachine/VigilantAntiSubState")
require("Mod/Battle/Data/Unit/BattleUnit")
require("Mod/Battle/Data/Unit/BattlePlayerUnit")
require("Mod/Battle/Data/Unit/BattleEnemyUnit")
require("Mod/Battle/Data/Unit/BattleBossUnit")
require("Mod/Battle/Data/Unit/BattleNPCUnit")
require("Mod/Battle/Data/Unit/BattleSubUnit")
require("Mod/Battle/Data/Unit/BattleMinionUnit")
require("Mod/Battle/Data/Unit/BattleCardPuzzlePlayerUnit")
require("Mod/Battle/Data/Unit/BattleSupportUnit")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffEffect")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAttr")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAttrRatio")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAttrBloodrage")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAttrCommander")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAttrRatioCommander")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCastSkill")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCastSkillRandom")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffHP")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffHPLink")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddBuff")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCancelBuff")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCleanse")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffDOT")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffHOT")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddBulletAttr")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffBulletHitEmitter")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffSize")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffNewWeapon")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffNewAI")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffField")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffSetAttr")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCount")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddProficiency")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffDeath")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffStory")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffLink")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAirStrikeCoolDown")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffManualTorpedoCoolDown")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffStun")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffWorldVariable")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShieldWall")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShield")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddReloadRequirement")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffFixAmmo")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffFixDamage")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShiftBullet")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShiftWeapon")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffOrb")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffMountExpand")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddTag")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShiftWeaponSkin")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffHealingSteal")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffHealingCorrupt")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAntiSubVigilance")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAntiSubMine")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffFixRange")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffOverrideBullet")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffFixVelocity")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffDiva")
require("Mod/Battle/Data/Buff/BuffEffect/BattleNodeBuff")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffBlindedHorizon")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddForce")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAura")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffShiftBarrage")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffBarrier")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAdditiveSpeed")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffDamageWall")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffRegisterWaveFlags")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCease")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffLockHealth")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffRemoteBone")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAircraftAttr")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffGuarded")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffTaunt")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffOverHealingShield")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAuraSquare")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAircraftTag")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffSetBattleUnitType")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffActionKeyOffset")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffAddAircraftOrb")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCoverSpine")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffDamageConvert")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffCastSkillDamageCount")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffSmokeAimBias")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffSwitchShader")
require("Mod/Battle/Data/Buff/BuffEffect/BattleBuffUnstoppable")
require("Mod/Battle/Data/Buff/BattleBuffUnit")
require("Mod/Battle/Data/Buff/BattleBuffSelfModifyUnit")
require("Mod/Battle/Data/Buff/BattleFleetBuffUnit")
require("Mod/Battle/Data/Buff/FleetBuffEffect/BattleFleetBuffEffect")
require("Mod/Battle/Data/Buff/FleetBuffEffect/BattleFleetBuffInk")
require("Mod/Battle/Data/Buff/FleetBuffEffect/BattleFleetBuffBlindAura")
require("Mod/Battle/Data/Buff/FleetBuffEffect/BattleFleetBuffSonarExtraRange")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillEffect")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillAddBuff")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillDamage")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillHeal")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillFire")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillWeaponFire")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillSummon")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillSonar")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillEditTag")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillProjectShelter")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillInstantCoolDown")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillOverrideAutoPilot")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillAddFleetBuff")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillFireSupport")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillTeleport")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillCLS")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillPlayFX")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillPlayUIFX")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillPlayCameraFX")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillManualWeaponReloadBoost")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillChangeDiveState")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillCLSArea")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillPhaseJump")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillRemoveAllWeapon")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillEditFleetAttr")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillConsumeBuff")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillSetCloak")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillEditCustomWarning")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillFusion")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillGridmanFloat")
require("Mod/Battle/Data/Skill/SkillEffect/BattleSkillProjectArea")
require("Mod/Battle/Data/Skill/BattleSkillUnit")
require("Mod/Battle/Data/Aircraft/BattleAircraftUnit")
require("Mod/Battle/Data/Aircraft/BattleAirFighterUnit")
require("Mod/Battle/Data/Aircraft/BattleFunnelUnit")
require("Mod/Battle/Data/Aircraft/BattleUAVUnit")
require("Mod/Battle/Data/Aircraft/BattlePatternFunnelUnit")
require("Mod/Battle/Data/Bullet/BattleBulletUnit")
require("Mod/Battle/Data/Bullet/BattleCannonBulletUnit")
require("Mod/Battle/Data/Bullet/BattleBombBulletUnit")
require("Mod/Battle/Data/Bullet/BattleTorpedoBulletUnit")
require("Mod/Battle/Data/Bullet/BattleAntiAirBulletUnit")
require("Mod/Battle/Data/Bullet/BattleAntiSeaBulletUnit")
require("Mod/Battle/Data/Bullet/BattleShrapnelBulletUnit")
require("Mod/Battle/Data/Bullet/BattleStrayBulletUnit")
require("Mod/Battle/Data/Bullet/BattleEffectBulletUnit")
require("Mod/Battle/Data/Bullet/BattleBeamUnit")
require("Mod/Battle/Data/Bullet/BattleGravitationBulletUnit")
require("Mod/Battle/Data/Bullet/BattleMissileUnit")
require("Mod/Battle/Data/Bullet/BattleScaleBulletUnit")
require("Mod/Battle/Data/Bullet/BattleAreaBulletUnit")
require("Mod/Battle/Data/Bullet/BattleColumnAreaBulletUnit")
require("Mod/Battle/Data/Bullet/BattleSpaceLaserUnit")
require("Mod/Battle/Data/Bullet/BattleTrackingAAMissileUnit")
require("Mod/Battle/Data/Weapon/BattleBulletEmitter")
require("Mod/Battle/Data/Weapon/BattleShotgunEmitter")
require("Mod/Battle/Data/Weapon/BattleWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleAntiAirUnit")
require("Mod/Battle/Data/Weapon/BattleTorpedoUnit")
require("Mod/Battle/Data/Weapon/BattleManualTorpedoUnit")
require("Mod/Battle/Data/Weapon/BattleDisposableTorpedoUnit")
require("Mod/Battle/Data/Weapon/BattleHiveUnit")
require("Mod/Battle/Data/Weapon/BattleDirectHitWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleHammerHeadWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleBombWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleSpecialWeapon")
require("Mod/Battle/Data/Weapon/BattlePointHitWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleAllInStrike")
require("Mod/Battle/Data/Weapon/BattleFleetAntiAirUnit")
require("Mod/Battle/Data/Weapon/BattleRepeaterAntiAirUnit")
require("Mod/Battle/Data/Weapon/BattleLaserUnit")
require("Mod/Battle/Data/Weapon/BattleDepthChargeUnit")
require("Mod/Battle/Data/Weapon/BattleIndieSonar")
require("Mod/Battle/Data/Weapon/BattleMissileWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleFleetStaticSonar")
require("Mod/Battle/Data/Weapon/BattleSpaceLaserWeaponUnit")
require("Mod/Battle/Data/Weapon/BattleFleetRangeAntiAirUnit")
require("Mod/Battle/Data/Weapon/BattleManualAAMissileUnit")
require("Mod/Battle/Data/Weapon/BattleAutoMissileUnit")
require("Mod/Battle/Data/Weapon/BattleSupportHiveUnit")
require("Mod/Battle/Data/Weapon/BattleFleetCardPuzzleAntiAirUnit")
require("Mod/Battle/Data/SceneObj/BattleAOEData")
require("Mod/Battle/Data/SceneObj/BattleLastingAOEData")
require("Mod/Battle/Data/SceneObj/BattleWallData")
require("Mod/Battle/Data/SceneObj/BattleShelterData")
require("Mod/Battle/Data/SceneObj/BattleTriggerAOEData")
require("Mod/Battle/Data/SceneObj/BattleAOEMobilizedComponent")
require("Mod/Battle/Data/SceneObj/BattleAOEScaleableComponent")
require("Mod/Battle/Data/Environment/BattleEnvironmentUnit")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviour")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourDamage")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourBuff")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourMovement")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourForce")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourSpawn")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourPlayFX")
require("Mod/Battle/Data/Environment/BattleEnvironmentBehaviourShakeScreen")
require("Mod/Battle/View/Camera/BattleCameraUtil")
require("Mod/Battle/View/Camera/BattleCameraBoundFixDecorate")
require("Mod/Battle/View/Camera/BattleCameraFocusChar")
require("Mod/Battle/View/Camera/BattleCameraFocusBullet")
require("Mod/Battle/View/Camera/BattleCameraFollowPilot")
require("Mod/Battle/View/Camera/BattleCameraFollowGesture")
require("Mod/Battle/View/Camera/BattleCameraTween")
require("Mod/Battle/View/BattleResourceManager")
require("Mod/Battle/View/BattleFXPool")
require("Mod/Battle/View/BattleCharacterFXContainersPool")
require("Mod/Battle/View/UI/BattleUIMediator")
require("Mod/Battle/View/UI/FormationPanel/BattleTimerView")
require("Mod/Battle/View/UI/FormationPanel/BattleDamageRateView")
require("Mod/Battle/View/UI/FormationPanel/BattleDuelDamageRateView")
require("Mod/Battle/View/UI/FormationPanel/BattleEnmeyHpBarView")
require("Mod/Battle/View/UI/FormationPanel/BattleDropsView")
require("Mod/Battle/View/UI/FormationPanel/BattleCameraSlider")
require("Mod/Battle/View/UI/FormationPanel/BattleUnitDetailView")
require("Mod/Battle/View/UI/FormationPanel/BattleSimulationBuffCountView")
require("Mod/Battle/View/UI/FormationPanel/BattleReisalinAPView")
require("Mod/Battle/View/UI/FormationPanel/BattleGridmanSkillFloatView")
require("Mod/Battle/View/UI/FormationPanel/BattleWeaponButton")
require("Mod/Battle/View/UI/FormationPanel/BattleSubmarineButton")
require("Mod/Battle/View/UI/FormationPanel/BattleSubmarineFuncButton")
require("Mod/Battle/View/UI/FormationPanel/BattleCustomWarningLabel")
require("Mod/Battle/View/UI/FormationPanel/BattleSkillView")
require("Mod/Battle/View/UI/FormationPanel/BattleAirStrikeIconView")
require("Mod/Battle/View/UI/FormationPanel/BattleCommonWarningView")
require("Mod/Battle/View/UI/FormationPanel/BattleOpticalSightView")
require("Mod/Battle/View/UI/FormationPanel/BattleMainDamagedView")
require("Mod/Battle/View/UI/FormationPanel/BattleScoreBarView")
require("Mod/Battle/View/UI/FormationPanel/BattleInkView")
require("Mod/Battle/View/UI/FormationPanel/BattleDebugConsole")
require("Mod/Battle/View/BattleSceneMediator")
require("Mod/Battle/View/BattleReferenceBoxMediator")
require("Mod/Battle/View/BattleSceneObject")
require("Mod/Battle/View/CharacterFactory/BattleHPBarManager")
require("Mod/Battle/View/CharacterFactory/BattleArrowManager")
require("Mod/Battle/View/CharacterFactory/BattleCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattlePlayerCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleSubCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleEnemyCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleMinionCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleBossCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleNPCCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleAircraftCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleAirFighterCharacterFactory")
require("Mod/Battle/View/CharacterFactory/BattleMainFleetCharacterFactory")
require("Mod/Battle/View/Character/BattleCharacter")
require("Mod/Battle/View/Character/BattlePlayerCharacter")
require("Mod/Battle/View/Character/BattleSubCharacter")
require("Mod/Battle/View/Character/BattleMainFleetCharacter")
require("Mod/Battle/View/Character/BattleEnemyCharacter")
require("Mod/Battle/View/Character/BattleMinionCharacter")
require("Mod/Battle/View/Character/BattleBossCharacter")
require("Mod/Battle/View/Character/BattleNPCCharacter")
require("Mod/Battle/View/Character/BattleAircraftCharacter")
require("Mod/Battle/View/Character/BattleAirFighterCharacter")
require("Mod/Battle/View/Character/BattleEffectComponent")
require("Mod/Battle/View/BulletFactory/BattleBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleCannonBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleBombBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleTorpedoBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleAntiAirBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleAntiSeaBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleDirectBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleShrapnelBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleStrayBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleEffectBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleBeamBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleGravitationBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleElectricArcBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleSpaceLaserFactory")
require("Mod/Battle/View/BulletFactory/BattleMissileFactory")
require("Mod/Battle/View/BulletFactory/BattleScaleBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleTriggerBulletFactory")
require("Mod/Battle/View/BulletFactory/BattleAAMissileFactory")
require("Mod/Battle/View/Bullet/BattleBullet")
require("Mod/Battle/View/Bullet/BattleCannonBullet")
require("Mod/Battle/View/Bullet/BattleBombBullet")
require("Mod/Battle/View/Bullet/BattleTorpedoBullet")
require("Mod/Battle/View/Bullet/BattleShrapnelBullet")
require("Mod/Battle/View/Bullet/BattleStrayBullet")
require("Mod/Battle/View/Bullet/BattleScaleBullet")
require("Mod/Battle/View/Bullet/BattleLaserArea")
require("Mod/Battle/View/Scene/BattlePopNum")
require("Mod/Battle/View/Scene/BattlePopNumManager")
require("Mod/Battle/View/Scene/BattlePopNumBundle")
require("Mod/Battle/View/Scene/BattleChargeArea")
require("Mod/Battle/View/Scene/BattleAlert")
require("Mod/Battle/View/Scene/BattleCastBar")
require("Mod/Battle/View/Scene/BattleLockTag")
require("Mod/Battle/View/Scene/BattleVigilantBar")
require("Mod/Battle/View/Scene/TorAlert")
require("Mod/Battle/View/Scene/BossSkillAlert")
require("Mod/Battle/View/Scene/BattleMap")
require("Mod/Battle/View/Scene/BattleEffectArea")
require("Mod/Battle/View/Scene/BattleLaserEffect")
require("Mod/Battle/View/Scene/BattleArcEffect")
require("Mod/Battle/View/Scene/BattleBarrierBar")
require("Mod/Battle/View/Scene/BattleCloakBar")
require("Mod/Battle/View/Scene/BattleWeaponRangeSector")
require("Mod/Battle/View/Scene/BattleAimbiasBar")
require("Mod/Battle/View/Scene/BattleBuffClock")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleJoyStickAutoBot")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleControlStrategy")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleMoveState")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleIMoveState")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleRandomState")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleStayState")
require("Mod/Battle/Data/CardPuzzle/movement/CardPuzzleMoveToState")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleBoardClicker")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleCommonHPBar")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleFleetHead")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleEnergyBar")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleHandPool")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleMovePile")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleHandCardButton")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleDeckPool")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleFleetIconList")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleCombatCard")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleHandBoard")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleCardDetail")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleCardDetailAffix")
require("Mod/Battle/View/UI/FormationPanel/CardPuzzleGoalRemind")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillEffect")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillFire")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillMoveTo")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillAddBuff")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillCreateCard")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillMoveCard")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillAddFleetBuff")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillAddFleetAttr")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillActiveCard")
require("Mod/Battle/Data/Skill/CardPuzzleSkillEffect/BattleCardPuzzleSkillSetFleetAttr")
require("Mod/Battle/Data/Buff/BattleCardPuzzleFleetBuffUnit")
require("Mod/Battle/Data/Buff/CardPuzzleFleetBuffEffect/BattleCardPuzzleFleetBuffEffect")
require("Mod/Battle/Data/Buff/CardPuzzleFleetBuffEffect/BattleCardPuzzleFleetBuffAddFleetAttr")
require("Mod/Battle/Data/Buff/CardPuzzleFleetBuffEffect/BattleCardPuzzleFleetBuffSetFleetAttr")
require("Mod/Battle/Data/Buff/CardPuzzleFleetBuffEffect/BattleCardPuzzleFleetBuffAddBuff")
