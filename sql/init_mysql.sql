-- ApexHelper MySQL initialization script.
-- Target database: MySQL, charset utf8mb4.
-- Run this script before the course-design demo.

CREATE DATABASE IF NOT EXISTS apex_helper
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE apex_helper;

DROP TABLE IF EXISTS t_system_log;
DROP TABLE IF EXISTS t_tactic_note;
DROP TABLE IF EXISTS t_log;
DROP TABLE IF EXISTS t_strategy_note;
DROP TABLE IF EXISTS t_player_stats;
DROP TABLE IF EXISTS t_player_stat;
DROP TABLE IF EXISTS t_weapon;
DROP TABLE IF EXISTS t_legend;
DROP TABLE IF EXISTS t_user;

CREATE TABLE t_user (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  avatar VARCHAR(255) DEFAULT 'static/img/default-avatar.png',
  role VARCHAR(20) NOT NULL DEFAULT 'user',
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_legend (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  english_name VARCHAR(80) NOT NULL,
  position VARCHAR(50) NOT NULL,
  skill_desc TEXT NOT NULL,
  tactic_tip TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_weapon (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  english_name VARCHAR(80) NOT NULL,
  weapon_type VARCHAR(50) NOT NULL,
  damage INT NOT NULL DEFAULT 0,
  ammo_type VARCHAR(50) NOT NULL,
  recommend_scene TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_tactic_note (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  map_name VARCHAR(50) NOT NULL,
  legend_name VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_tactic_note_user FOREIGN KEY (user_id) REFERENCES t_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_player_stat (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nickname VARCHAR(50) NOT NULL UNIQUE,
  rank_name VARCHAR(50) NOT NULL,
  total_kills INT NOT NULL DEFAULT 0,
  total_damage INT NOT NULL DEFAULT 0,
  wins INT NOT NULL DEFAULT 0,
  main_legend VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_system_log (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  username VARCHAR(50),
  action_type VARCHAR(50) NOT NULL,
  action_content VARCHAR(255) NOT NULL,
  create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_system_log_user FOREIGN KEY (user_id) REFERENCES t_user(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO t_user (username, password, avatar, role) VALUES
('admin', 'admin123', 'static/img/default-avatar.png', 'admin'),
('player', 'player123', 'static/img/default-avatar.png', 'user');

INSERT INTO t_legend (name, english_name, position, skill_desc, tactic_tip) VALUES
('寻血猎犬', 'Bloodhound', '侦察/追踪', '扫描前方敌人并追踪敌人活动痕迹，终极技能强化移动和视野。', '进攻前先扫描确认人数，追击时注意不要和队友脱节。'),
('直布罗陀', 'Gibraltar', '支援/防守', '枪盾、保护穹顶和防御性轰炸让队伍在开阔地也能短时间稳住阵地。', '穹顶适合拉人、补甲和强行换位，轰炸可用来逼退高点敌人。'),
('命脉', 'Lifeline', '支援/治疗', '治疗无人机和支援能力帮助队伍持续作战。', '阵地战优先保留治疗无人机，倒地队友周围先找掩体再复活。'),
('探路者', 'Pathfinder', '游击/转点', '抓钩快速位移，滑索帮助全队跨越地形。', '先侦察安全路线再架滑索，避免把队伍送到无掩体位置。'),
('恶灵', 'Wraith', '游击/转移', '虚空技能规避伤害，传送门帮助队伍进退场。', '适合负责探点和撤离路线，开传送门前先确认队友位置。'),
('班加罗尔', 'Bangalore', '突击/掩护', '烟雾发射器遮挡视线，被动加速，终极技能提供区域压制。', '烟雾适合撤退和拉人，配合数字威胁镜或扫描队友效果更好。'),
('腐蚀', 'Caustic', '控制/防守', '毒气陷阱和毒气手雷适合封锁房区和门口。', '守楼时把陷阱放在入口内侧，进攻时用毒气限制敌人走位。'),
('幻象', 'Mirage', '支援/迷惑', '诱饵和隐身复活可以干扰敌人判断。', '交火前先放诱饵骗枪线，复活队友时利用隐身争取时间。'),
('动力小子', 'Octane', '游击/突进', '兴奋剂提升速度，跳板帮助全队快速转移或冲点。', '跳板进场前先确认落点，避免单人过深。'),
('沃特森', 'Wattson', '控制/防守', '电网和拦截塔适合守点、挡投掷物和恢复护盾。', '决赛圈提前布防，拦截塔放在掩体后。'),
('密客', 'Crypto', '侦察/信息', '无人机侦察、扫旗和 EMP 可破坏敌方防守。', '队友架枪时再放 EMP，避免自己离战场太远。'),
('亡灵', 'Revenant', '突击/追杀', '强化位移和暗影能力适合追击残血目标。', '开团时找侧翼切入，优先压低敌方后排。'),
('罗芭', 'Loba', '支援/补给', '盗贼之眼和黑市精品店帮助队伍快速补给。', '转点前用黑市补弹药和治疗，别在暴露位置久站。'),
('兰伯特', 'Rampart', '控制/火力', '强化掩体和机枪适合架点压制。', '先架墙再输出，避免在无掩体位置硬架机枪。'),
('地平线', 'Horizon', '游击/高点', '重力电梯抢高点，黑洞聚拢敌人。', '先抢高点再输出，黑洞配合投掷物可以打出爆发。'),
('暴雷', 'Fuse', '突击/投掷物', '被动携带更多投掷物，战术技能和终极技能能持续压制区域。', '开团前用投掷物消耗，终极技能适合封路或逼掩体。'),
('瓦尔基里', 'Valkyrie', '游击/转点', '喷气背包和飞天转点帮助队伍跨越地图。', '大招适合提前转圈，起飞前确认周围没有近点敌人。'),
('希尔', 'Seer', '侦察/打断', '心跳探测和战术技能可以暴露并打断敌人。', '敌人打药或复活时使用战术技能，团战中保持信息压制。'),
('艾许', 'Ash', '突击/追击', '被动追踪死亡盒，战术技能限制敌人移动，终极技能快速突进。', '适合抓单和追击，传送前确认队友能跟上。'),
('疯玛吉', 'Mad Maggie', '突击/破点', '钻头和破坏球适合打掩体后的敌人。', '先用钻头逼敌人离开掩体，再配合霰弹枪近身压制。'),
('纽卡斯尔', 'Newcastle', '支援/保护', '移动盾和城墙保护队友，复活时能拖动倒地队友。', '优先保护被集火队友，城墙可用来强行建立前线掩体。'),
('万蒂奇', 'Vantage', '侦察/狙击', '蝙蝠位移和狙击标记强化远程开团。', '远距离先标记关键目标，换点时利用回声位移找角度。'),
('催化姬', 'Catalyst', '控制/封锁', '铁磁流体加固门和布置尖刺，暗幕切割战场视线。', '守门和分割战场很强，暗幕适合掩护转点或隔断枪线。'),
('弹道', 'Ballistic', '突击/武器强化', '携带第三把武器并用技能干扰敌方武器，终极技能强化队伍装填和移动。', '开团前切好备用武器，大招适合近距离爆发推进。'),
('导管', 'Conduit', '支援/护盾', '为队友临时恢复护盾并用能量装置限制区域。', '队友破甲时及时补临时护盾，终极技能适合卡门和控圈边。'),
('变幻', 'Alter', '游击/传送', '虚空通道和团队召回能力改变交火路线。', '利用墙体传送打侧翼，终极技能给队伍留撤退点。'),
('斯派洛', 'Sparrow', '侦察/陷阱', '以弓箭和追踪装置提供侦察与区域干扰。', '先用侦察能力确认敌人位置，再用陷阱限制绕后路线。'),
('阿克塞尔', 'Axle', '突击/近战压制', '最新 Overclocked 赛季加入的传奇，强调近距离突破和队伍推进。', '适合配合霰弹枪或冲锋枪强压房区，开团前让队友跟上节奏。');

INSERT INTO t_weapon (name, english_name, weapon_type, damage, ammo_type, recommend_scene) VALUES
('哈沃克步枪', 'HAVOC Rifle', '突击步枪', 18, '能量弹药', '中近距离持续输出强，搭配涡轮增压器手感更好。'),
('赫姆洛克突击步枪', 'Hemlok Burst AR', '突击步枪', 20, '重型弹药', '三连发适合中距离点射，控枪稳定时压制力很强。'),
('赫姆洛克突破型突击步枪', 'Hemlok Breach AR', '突击步枪/精英武器', 22, '重型弹药', '最新轮换中的高爆发版本，适合中近距离破点。'),
('VK-47 平行步枪', 'VK-47 Flatline', '突击步枪', 19, '重型弹药', '中近距离压制强，适合会控枪的玩家。'),
('R-301 卡宾枪', 'R-301 Carbine', '突击步枪', 14, '轻型弹药', '中距离稳定输出，适合新手和通用主武器。'),
('复仇女神爆能步枪', 'Nemesis Burst AR', '突击步枪', 17, '能量弹药', '蓄速后连发压制强，适合中距离持续架枪。'),
('转换者冲锋枪', 'Alternator SMG', '冲锋枪', 18, '轻型弹药', '稳定易控，适合前期和近中距离换血。'),
('猎兽冲锋枪', 'Prowler Burst PDW', '冲锋枪', 16, '重型弹药', '五连发近战爆发高，适合贴脸秒破甲。'),
('R-99 冲锋枪', 'R-99 SMG', '冲锋枪', 12, '轻型弹药', '射速极快，适合近距离爆发和收割。'),
('电能冲锋枪', 'Volt SMG', '冲锋枪', 16, '能量弹药', '弹道稳定，近中距离都好用。'),
('C.A.R. 冲锋枪', 'C.A.R. SMG', '冲锋枪', 13, '轻型/重型弹药', '弹药兼容性高，适合近距离主武器。'),
('专注轻机枪', 'Devotion LMG', '轻机枪', 16, '能量弹药', '预热后火力强，适合压门和守点。'),
('L-STAR 能量机枪', 'L-STAR EMG', '轻机枪/空投', 20, '能量弹药', '最新轮换中为空投强势火力，适合持续压制。'),
('M600 喷火轻机枪', 'M600 Spitfire', '轻机枪', 19, '轻型弹药', '弹匣大，适合新手持续输出和压制。'),
('狂暴轻机枪', 'Rampage LMG', '轻机枪', 28, '重型弹药', '单发伤害高，装填铝热剂后适合中距离压制。'),
('G7 斥候', 'G7 Scout', '射手武器', 34, '轻型弹药', '中远距离点射稳定，适合消耗和架枪。'),
('三重式狙击枪', 'Triple Take', '射手武器', 63, '能量弹药', '弹道宽容度高，适合中远距离消耗。'),
('30-30 连发枪', '30-30 Repeater', '射手武器', 42, '重型弹药', '蓄力点射伤害高，适合中远距离破甲。'),
('波塞克复合弓', 'Bocek Compound Bow', '射手武器', 70, '箭矢', '隐蔽性好，适合中距离精准消耗。'),
('充能步枪', 'Charge Rifle', '狙击枪', 75, '狙击弹药', '远距离命中伤害高，适合消耗和逼迫敌人换位。'),
('长弓精确步枪', 'Longbow DMR', '狙击枪', 55, '狙击弹药', '射速和伤害均衡，适合远距离点名。'),
('克雷贝尔狙击枪', 'Kraber .50-Cal Sniper', '狙击枪/空投', 140, '特殊弹药', '高风险高收益空投狙，适合先手击倒。'),
('哨兵狙击步枪', 'Sentinel', '狙击枪', 70, '狙击弹药', '蓄能后爆发高，适合远距离破甲开团。'),
('EVA-8 自动霰弹枪', 'EVA-8 Auto', '霰弹枪', 63, '霰弹', '容错率高，适合近距离连续输出。'),
('獒犬霰弹枪', 'Mastiff Shotgun', '霰弹枪', 88, '霰弹', '横向弹丸适合贴脸和门口对枪。'),
('莫桑比克霰弹枪', 'Mozambique Shotgun', '霰弹枪', 45, '霰弹', '副武器和前期过渡好用，近距离收割稳定。'),
('和平捍卫者', 'Peacekeeper', '霰弹枪', 99, '霰弹', '近距离爆发高，适合守门和室内作战。'),
('RE-45 自动手枪', 'RE-45 Auto', '手枪', 14, '轻型弹药', '射速快，适合前期和近距离补伤害。'),
('P2020 手枪', 'P2020', '手枪', 24, '轻型弹药', '最新补丁提升基础表现，适合前期和双持玩法。'),
('辅助手枪', 'Wingman', '手枪', 45, '狙击弹药', '单发伤害高，适合中近距离精准点射。');

INSERT INTO t_tactic_note (user_id, title, map_name, legend_name, content) VALUES
(2, '破碎月中圈转移', '破碎月', '恶灵', '第二圈开始提前观察轨道站附近队伍，必要时用传送门带队友绕开正面交火。'),
(2, '奥林匹斯高点防守', '奥林匹斯', '地平线', '先占住宅区屋顶，用重力电梯保持高点压制，被集火时马上换楼顶。');

INSERT INTO t_player_stat (nickname, rank_name, total_kills, total_damage, wins, main_legend) VALUES
('ImperialHal', '大师', 120000, 9800000, 8200, '班加罗尔'),
('iiTzTimmy', '大师', 95000, 7600000, 6100, '地平线'),
('Ras', '猎杀者', 110000, 9000000, 7800, '恶灵'),
('ApexStudent', '黄金', 2300, 410000, 120, '命脉'),
('StormPointMain', '白金', 8600, 1330000, 540, '寻血猎犬');

INSERT INTO t_system_log (user_id, username, action_type, action_content) VALUES
(1, 'admin', '初始化', '系统初始化管理员账号'),
(2, 'player', '初始化', '系统初始化普通用户账号和示例笔记');
