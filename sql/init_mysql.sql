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
  position VARCHAR(50) NOT NULL,
  skill_desc TEXT NOT NULL,
  tactic_tip TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_weapon (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
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

INSERT INTO t_legend (name, position, skill_desc, tactic_tip) VALUES
('恶灵', '突击/转移', '被动提示危险，战术技能进入虚空规避伤害，终极技能建立维度裂隙。', '适合负责探点和撤离路线，开传送门前先确认队友位置。'),
('寻血猎犬', '侦查/追踪', '被动发现敌人踪迹，战术技能扫描前方敌人，终极技能提升视野和移动能力。', '进攻前先扫描，避免在开阔地暴露后长时间停留。'),
('命脉', '支援/治疗', '可以用无人机治疗队友，补给仓提供装备，复活时能维持队伍节奏。', '阵地战优先保存治疗无人机，倒地队友周围先封烟或找掩体。'),
('班加罗尔', '突击/掩护', '被动加速，烟雾发射器遮挡视线，终极技能进行区域轰炸。', '烟雾适合撤退和拉人，配合数字威胁镜效果更好。'),
('地平线', '游击/高点', '战术技能重力电梯帮助上高点，终极技能黑洞能聚拢敌人。', '先抢高点再输出，黑洞配合投掷物可以打出爆发。');

INSERT INTO t_weapon (name, weapon_type, damage, ammo_type, recommend_scene) VALUES
('R-301 卡宾枪', '突击步枪', 14, '轻型弹药', '中距离稳定输出，适合新手和通用主武器。'),
('平行步枪', '突击步枪', 18, '重型弹药', '中近距离压制强，适合会控枪的玩家。'),
('和平捍卫者', '霰弹枪', 99, '霰弹', '近距离爆发高，适合守门和室内作战。'),
('辅助手枪', '手枪', 45, '重型弹药', '单发伤害高，适合中近距离点射。'),
('电能冲锋枪', '冲锋枪', 15, '能量弹药', '近距离射速快，适合贴脸突击。');

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
