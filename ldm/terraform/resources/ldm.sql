USE ldm;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_ldm_base_ability_group_h
-- ----------------------------
CREATE TABLE `t_ldm_base_ability_group_h` (
  `ability_group_h_id` varchar(64) NOT NULL COMMENT '设备能力组ID',
  `ability_group_name` varchar(250) DEFAULT NULL COMMENT '设备能力组名（唯一的）',
  `ability_group_priority` int DEFAULT NULL COMMENT '设备能力组优先级（当最低设备无法保障时）',
  `device_type_code` text COMMENT '设备类型编号（支持多个设备类型用逗号隔开）',
  `standard_device_qty` bigint DEFAULT NULL COMMENT '标准设备数',
  `min_device_qty` bigint DEFAULT NULL COMMENT '最小设备数',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `ability_group_code` varchar(64) DEFAULT NULL COMMENT '设备能力组编码',
  `cross_map_flag` varchar(1) DEFAULT NULL COMMENT '跨地图标识Y/N(默认为N)',
  PRIMARY KEY (`ability_group_h_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_group_h_u1` (`ability_group_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备能力组头表';

-- ----------------------------
-- Table structure for t_ldm_base_ability_group_l
-- ----------------------------
CREATE TABLE `t_ldm_base_ability_group_l` (
  `ability_group_l_id` varchar(64) NOT NULL COMMENT '设备能力组明细ID，自动生成GUID',
  `ability_group_h_id` varchar(64) DEFAULT NULL COMMENT '设备能力组ID',
  `ability_group_code` varchar(64) DEFAULT NULL COMMENT '设备能力组编码',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `ability_group_l_code` varchar(64) DEFAULT NULL COMMENT '设备能力组明细编码',
  `agv_limit_qty` int DEFAULT NULL COMMENT 'AGV限制数量',
  PRIMARY KEY (`ability_group_l_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备能力组行表';

-- ----------------------------
-- Table structure for t_ldm_base_agv_ability
-- ----------------------------
CREATE TABLE `t_ldm_base_agv_ability` (
  `ability_id` varchar(64) NOT NULL COMMENT '设备能力ID',
  `area_id` varchar(64) DEFAULT NULL COMMENT '区域ID',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编号',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `ability_group_l_id` varchar(64) DEFAULT NULL COMMENT '设备能力组明细ID',
  `ability_priority` bigint DEFAULT NULL COMMENT '设备能力优先级（默认99）',
  PRIMARY KEY (`ability_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='AGV/叉车等设备能力';

-- ----------------------------
-- Table structure for t_ldm_base_area
-- ----------------------------
CREATE TABLE `t_ldm_base_area` (
  `area_id` varchar(64) NOT NULL COMMENT '主键',
  `area_code` varchar(64) NOT NULL COMMENT '区域编号',
  `area_name` varchar(64) DEFAULT NULL COMMENT '区域名称',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `lock_flag` varchar(1) DEFAULT NULL COMMENT '是否锁定,封锁区域',
  `mask_num` smallint DEFAULT NULL COMMENT '关联地图数据（交管区的ID）（控件的区域ID）',
  `area_coordinate` text COMMENT '库区坐标',
  `area_type` varchar(32) DEFAULT NULL COMMENT '库区类型1：暂存区2：分拣区3：收货区4::  线边仓5：存储区',
  `area_locator_prefix` varchar(32) DEFAULT NULL COMMENT '库区货位前缀',
  `putin_area_code` int DEFAULT NULL COMMENT '上架暂存区ID',
  `putaway_area_code` int DEFAULT NULL COMMENT '下架暂存区ID',
  `building_floor` varchar(64) DEFAULT NULL COMMENT '楼层',
  `reserve_locator_qty` int DEFAULT NULL COMMENT '保留货位数量',
  `priority` smallint DEFAULT NULL COMMENT '优先级',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `outer_device_group` varchar(64) DEFAULT NULL COMMENT '外接设备分组名(同组同区域)',
  `security_standby_area_code` varchar(64) DEFAULT NULL COMMENT '(安全)待命区编码',
  `bottleneck_flag` varchar(1) DEFAULT NULL COMMENT '瓶颈区标识：Y/N,默认为N',
  `empty_shelf_apply_area_code` varchar(64) DEFAULT NULL COMMENT '空载具提供区',
  `area_storage_mode` smallint DEFAULT NULL COMMENT '区域存放方式(1：载具；2：栈板）',
  `can_stride_road` char(1) DEFAULT NULL COMMENT '是否可以跨巷道：Y=可以；N=不可以；默认为N，空转换为N',
  `business_warehouse_code` varchar(64) DEFAULT NULL COMMENT '业务仓库代码',
  `smooth_num` smallint DEFAULT NULL COMMENT '平滑数量',
  `area_thread_id` varchar(64) DEFAULT NULL COMMENT '区域线程ID',
  `heartbeat_time` datetime DEFAULT NULL COMMENT '心跳时间',
  `io_device_code` varchar(32) DEFAULT NULL COMMENT 'IO设备编号',
  `command_running_num` smallint DEFAULT NULL COMMENT '允许运行最大指令数',
  PRIMARY KEY (`area_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_area_u1` (`area_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='区域表';

-- ----------------------------
-- Table structure for t_ldm_base_cmd_split_h
-- ----------------------------
CREATE TABLE `t_ldm_base_cmd_split_h` (
  `split_h_id` varchar(64) NOT NULL COMMENT '指令拆分头ID（主键）',
  `scene_name` varchar(64) DEFAULT NULL COMMENT '场景名称',
  `scene_desc` text COMMENT '场景描述',
  `source_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `task_type` varchar(32) DEFAULT NULL COMMENT '任务类型(约定，包括WMS发起，与MLM发起，设备发起)',
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `site_code` varchar(64) DEFAULT NULL COMMENT '工厂编码',
  `warehouse_id` varchar(64) DEFAULT NULL COMMENT '逻辑仓库ID',
  `from_area_id` varchar(64) DEFAULT NULL COMMENT '源货区ID',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `to_area_id` varchar(64) DEFAULT NULL COMMENT '目标货区ID',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标货区代码',
  `valid_flag` varchar(2) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `business_warehouse_code` varchar(64) DEFAULT NULL COMMENT '业务仓库代码',
  `is_simple_path` varchar(1) DEFAULT NULL COMMENT '是否简易路径（Y/N,默认为N)',
  PRIMARY KEY (`split_h_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='指令拆分头';

-- ----------------------------
-- Table structure for t_ldm_base_cmd_split_l
-- ----------------------------
CREATE TABLE `t_ldm_base_cmd_split_l` (
  `split_l_id` varchar(64) NOT NULL COMMENT '指令拆分行ID（主键）',
  `split_h_id` varchar(64) DEFAULT NULL COMMENT '指令拆分头ID（关联头表）',
  `command_no` smallint DEFAULT NULL COMMENT '指令序号（同SPLIT_H_ID下指令的排列序号）',
  `same_agv_grp_id` bigint DEFAULT NULL COMMENT '下发到相同AGV分组ID（序列）',
  `command_type` varchar(32) DEFAULT NULL COMMENT '指令类型（MOVE行走/DELIVERY搬运/RECHARGE充电/ROTATE旋转）',
  `bussiness_type` varchar(32) DEFAULT NULL COMMENT '业务类型（10接收转运/20入库转运/30...）（来源数据字典）',
  `command_desc` text COMMENT '指令描述',
  `pre_trigger_mode` smallint NOT NULL COMMENT '指令前置触发模式（1=直接触发（默认）/2=关联指令状态触发/3=关联指令完成延时触发\r\n/4=前置事件触发）',
  `pre_command_no` smallint DEFAULT NULL COMMENT '关联指令状态触发指令序号（仅关联指令触发模式下生效）',
  `pre_event_code` varchar(64) DEFAULT NULL COMMENT '前置事件触发事件代码（仅事件触发模式下生效）',
  `pre_timer_set` smallint DEFAULT NULL COMMENT '关联指令完成延时触发时间（秒），按指令完成时间计算',
  `suf_event_code` text COMMENT '后置驱动事件代码（支持多个事件逗号隔开，数据字典控制最大事件数）',
  `cur_command_percent` smallint DEFAULT NULL COMMENT '当前指令完成比例0-100触发后置驱动事件执行',
  `from_area_id` varchar(64) DEFAULT NULL COMMENT '源货区ID',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `to_area_id` varchar(64) DEFAULT NULL COMMENT '目标货区ID',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标货区代码',
  `to_map_data_code` varchar(64) DEFAULT NULL COMMENT '目标货位（固定目标位时启用）',
  `agv_lift_start_flag` varchar(2) DEFAULT NULL COMMENT '指令开始后AGV举升标识（Y举升/N放下/B保持）',
  `agv_lift_end_flag` varchar(2) DEFAULT NULL COMMENT '指令完成后AGV举升标识（Y举升/N放下）',
  `occupied_alarm_flag` varchar(2) DEFAULT NULL COMMENT '目的位置被占用是否报警标识(Y报警/N不报警)，停用',
  `check_lpn_flag` varchar(2) DEFAULT NULL COMMENT '是否检查LPN（Y/N）',
  `task_finish_flag` varchar(2) DEFAULT NULL COMMENT 'Y=当前指令完成TASK则完成，用于计算任务计划完成时间，一个拆分头下，只能有一条指令为Y，默认最后一条指令为Y',
  `can_overlap_flag` varchar(2) DEFAULT NULL COMMENT 'AGV分段式配送可跳过标识',
  `valid_flag` varchar(2) DEFAULT NULL COMMENT '是否可用，默认Y',
  `disable_date` datetime DEFAULT NULL COMMENT '失效日期',
  `disable_reason_code` varchar(64) DEFAULT NULL COMMENT '不可用原因代码（仅在设备不可用时生效）',
  `delete_flag` varchar(2) DEFAULT NULL COMMENT '记录删除标识Y/N;默认N',
  `overlap_flag` varchar(2) DEFAULT NULL COMMENT '可覆盖标识',
  `to_map_data_type` varchar(64) DEFAULT NULL COMMENT '目标货位类型',
  `shelf_type_code` varchar(64) DEFAULT NULL COMMENT '载具类型',
  `gtp_lpn_type` varchar(4) DEFAULT NULL,
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `pre_command_status` smallint DEFAULT NULL COMMENT '关联指令状态触发的指令状态',
  `assign_locator_strategy` smallint DEFAULT NULL COMMENT '建议货位策略：1=就近建议货位；2=就远建议货位；3=上架优先级建议货位；默认为1，策略为空时，默认为1',
  `can_overlap_cmd_no` smallint DEFAULT NULL COMMENT '指令可跳过关联指令编号',
  `link_command_no` smallint DEFAULT NULL COMMENT '衔接指令编号',
  `link_area_code` varchar(64) DEFAULT NULL COMMENT '衔接指令源区域',
  `link_timeout` decimal(65,30) DEFAULT NULL COMMENT '衔接指令超时时间设置(单位：S)',
  `same_lpn_group_id` bigint DEFAULT NULL COMMENT 'ELT_ONE多指令同组搬运对象',
  `auto_check_direction` varchar(8) DEFAULT NULL COMMENT '自动点检指令旋转方向',
  `auto_check_sensor_type` smallint DEFAULT NULL COMMENT '自动点检传感器类型',
  `agv_delay_waiting_time` decimal(65,30) DEFAULT NULL COMMENT 'agv延时等待时间(单位：S)',
  `stay_flag` varchar(1) DEFAULT NULL COMMENT 'agv指令完成保持标识（Y/N，默认N）',
  PRIMARY KEY (`split_l_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='指令拆分明细';

-- ----------------------------
-- Table structure for t_ldm_base_command_type
-- ----------------------------
CREATE TABLE `t_ldm_base_command_type` (
  `command_type_code` varchar(64) NOT NULL COMMENT '指令类型编号',
  `msg_temp_code` varchar(64) NOT NULL COMMENT '报文编号',
  `command_type_name` text COMMENT '指令类型名称',
  `command_msg_send` text COMMENT '指令消息体',
  `default_flag` varchar(1) DEFAULT NULL COMMENT '是否默认',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`command_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='指令类型';

-- ----------------------------
-- Table structure for t_ldm_base_device
-- ----------------------------
CREATE TABLE `t_ldm_base_device` (
  `device_id` varchar(64) NOT NULL COMMENT '设备ID',
  `device_code` varchar(64) NOT NULL COMMENT '设备编号',
  `device_name` varchar(256) DEFAULT NULL COMMENT '设备名称',
  `device_serial_code` varchar(64) DEFAULT NULL COMMENT '序列号',
  `device_type_id` varchar(64) DEFAULT NULL COMMENT '设备类型 外键t_ldm_base_device_type',
  `ability_group_code` varchar(64) DEFAULT NULL COMMENT '设备能力分组编码',
  `fix_ability_group_flag` varchar(1) DEFAULT 'N' COMMENT '固定设备能力分组标识（Y/N）默认：N',
  `device_ip` varchar(32) DEFAULT NULL COMMENT 'IP',
  `device_port` bigint DEFAULT NULL COMMENT '端口',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `contacts` varchar(64) DEFAULT NULL COMMENT '联系人',
  `status` smallint DEFAULT NULL COMMENT '状态（0：非排除；1：排除）',
  `device_version_id` varchar(64) DEFAULT NULL COMMENT '设备版本ID',
  `version_ignore_flag` varchar(2) DEFAULT NULL COMMENT '是否忽略版本号',
  `navigation_type` varchar(32) DEFAULT NULL COMMENT '导航类型（二维码、激光）',
  `manufacture` varchar(32) DEFAULT NULL COMMENT '所属厂商（用于区分不同设备归属：缩写简称，来自数据字典）',
  `opc_flag` varchar(1) DEFAULT 'N' COMMENT '是否启用OPC Y：启用 N：不启用',
  `opc_service_url` varchar(120) DEFAULT NULL COMMENT 'OPC服务对应的地址',
  `opc_program_id` varchar(30) DEFAULT NULL COMMENT '对应的OPC服务的programId（待确定）',
  `valid_flag` varchar(1) DEFAULT 'Y' COMMENT '是否有效 Y/N',
  `segment1` varchar(256) DEFAULT NULL COMMENT '主控版本',
  `segment2` varchar(256) DEFAULT NULL COMMENT 'RCU版本',
  `segment3` varchar(256) DEFAULT NULL COMMENT '定位库版本',
  `segment4` varchar(256) DEFAULT NULL COMMENT '感知库版本',
  `segment5` varchar(256) DEFAULT NULL COMMENT '图像库版本',
  `segment6` varchar(256) DEFAULT NULL COMMENT 'slam地图版本',
  `segment7` varchar(256) DEFAULT NULL COMMENT '本地地图版本',
  `segment8` varchar(256) DEFAULT NULL COMMENT '运动库版本',
  `segment9` varchar(256) DEFAULT NULL COMMENT '电池版本',
  `segment10` varchar(256) DEFAULT NULL COMMENT '扩展字段10',
  `segment11` varchar(256) DEFAULT NULL COMMENT '扩展字段11',
  `segment12` varchar(256) DEFAULT NULL COMMENT '扩展字段12',
  `segment13` varchar(256) DEFAULT NULL COMMENT '扩展字段13',
  `segment14` varchar(256) DEFAULT NULL COMMENT '扩展字段14',
  `segment15` varchar(256) DEFAULT NULL COMMENT '扩展字段15',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '最后更新时间',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '特定AGV固定的货架/载具编号',
  `device_weight` decimal(20,2) DEFAULT NULL COMMENT 'AGV净重(KG)',
  `lift_height` decimal(20,2) DEFAULT NULL COMMENT 'AGV举升高度(MM)',
  `principal` varchar(64) DEFAULT NULL COMMENT 'AGV责任人',
  `charge_strategy_id` varchar(2000) DEFAULT NULL COMMENT '充电策略编码',
  `department` varchar(256) DEFAULT NULL COMMENT '所属部门',
  `sub_department` varchar(256) DEFAULT NULL COMMENT '子部门',
  PRIMARY KEY (`device_id`) USING BTREE,
  UNIQUE KEY `device_code` (`device_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备表';

-- ----------------------------
-- Table structure for t_ldm_base_device_ext
-- ----------------------------
CREATE TABLE `t_ldm_base_device_ext` (
  `device_ext_id` varchar(64) NOT NULL COMMENT '设备扩展ID',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `exclusive_recharge` varchar(64) DEFAULT NULL COMMENT 'AGV专属充电点',
  `exclusive_stand_by` varchar(64) DEFAULT NULL COMMENT 'AGV专属待命点',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '最后更新时间',
  PRIMARY KEY (`device_ext_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备扩展表';

-- ----------------------------
-- Table structure for t_ldm_base_device_type
-- ----------------------------
CREATE TABLE `t_ldm_base_device_type` (
  `device_type_id` varchar(64) NOT NULL COMMENT '主键',
  `device_type_code` varchar(64) NOT NULL COMMENT '设备类型编号',
  `device_type_category` varchar(32) DEFAULT NULL COMMENT '设备类别（AGV/IAGV/CAMERA相机/INDICATOR指示灯/BUTTON按钮/LIFT电梯）',
  `device_type_name` varchar(256) DEFAULT NULL COMMENT '设备类型名称',
  `device_length` decimal(10,3) DEFAULT NULL COMMENT '长',
  `device_width` decimal(10,3) DEFAULT NULL COMMENT '宽',
  `device_height` decimal(10,3) DEFAULT NULL COMMENT '高',
  `device_load_weight` decimal(10,3) DEFAULT NULL COMMENT '设备负重',
  `device_direction_type` varchar(2) DEFAULT NULL COMMENT '全向，非全向.....',
  `device_standard_weight` decimal(10,3) DEFAULT NULL COMMENT '设备重量',
  `valid_flag` varchar(1) DEFAULT 'Y' COMMENT '是否有效 Y/N,默认Y',
  `segment1` varchar(256) DEFAULT NULL COMMENT '主控基准版本',
  `segment2` varchar(256) DEFAULT NULL COMMENT 'RCU基准版本',
  `segment3` varchar(256) DEFAULT NULL COMMENT '定位库基准版本',
  `segment4` varchar(256) DEFAULT NULL COMMENT '感知库基准版本',
  `segment5` varchar(256) DEFAULT NULL COMMENT '图像库基准版本',
  `segment6` varchar(256) DEFAULT NULL COMMENT 'slam地图版本',
  `segment7` varchar(256) DEFAULT NULL COMMENT '本地地图版本',
  `segment8` varchar(256) DEFAULT NULL COMMENT '运动库版本',
  `segment9` varchar(256) DEFAULT NULL COMMENT '电池版本',
  `segment10` varchar(256) DEFAULT NULL COMMENT '扩展字段10',
  `segment11` varchar(256) DEFAULT NULL COMMENT '扩展字段11',
  `segment12` varchar(256) DEFAULT NULL COMMENT '扩展字段12',
  `segment13` varchar(256) DEFAULT NULL COMMENT '扩展字段13',
  `segment14` varchar(256) DEFAULT NULL COMMENT '扩展字段14',
  `segment15` varchar(256) DEFAULT NULL COMMENT '扩展字段15',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp(6) NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp(6) NULL DEFAULT NULL COMMENT '最后更新时间',
  `fork_length_center_before` decimal(6,2) DEFAULT NULL COMMENT '中心前齿长',
  `fork_run_emp_height` decimal(6,2) DEFAULT NULL COMMENT '空叉行走高度（cm）',
  `fork_run_ful_height` decimal(6,2) DEFAULT NULL COMMENT '满叉行走高度（cm）',
  `fork_safety_height` decimal(6,2) DEFAULT NULL COMMENT '降叉安全高度（cm）',
  `fork_wheel_dis` decimal(6,2) DEFAULT NULL COMMENT '叉轮到车头距离（cm）',
  `charge_to_center_dis` decimal(6,2) DEFAULT NULL COMMENT '充电口到中心距离（cm）',
  `load_cent_offset` decimal(6,2) DEFAULT NULL COMMENT '叉齿举升误差（cm）',
  `manufacture` varchar(32) DEFAULT NULL COMMENT '所属厂商（用于区分不同设备归属：缩写简称，来自数据字典）',
  `device_attribute` varchar(128) DEFAULT NULL COMMENT '设备大类（顶升AGV、全向AGV、高架AGV、装载AGV）',
  PRIMARY KEY (`device_type_id`) USING BTREE,
  UNIQUE KEY `device_type_code` (`device_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备类型';

-- ----------------------------
-- Table structure for t_ldm_base_dict_option_def
-- ----------------------------
CREATE TABLE `t_ldm_base_dict_option_def` (
  `row_id` varchar(64) NOT NULL COMMENT '数据字典主键',
  `dict_row_id` varchar(64) DEFAULT NULL COMMENT '父项ID',
  `key` varchar(512) DEFAULT NULL COMMENT '字典代码',
  `value` text COMMENT '字典名称',
  `sort` int DEFAULT NULL COMMENT '字典选项排序',
  `lang` varchar(64) DEFAULT NULL COMMENT '语言',
  `attribute1` text COMMENT '保留1',
  `attribute2` text COMMENT '保留2',
  `attribute3` text COMMENT '保留3',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `attribute4` text COMMENT '保留4',
  `attribute5` text COMMENT '保留5',
  `attribute6` text COMMENT '保留6',
  `attribute7` text COMMENT '保留7',
  `attribute8` text COMMENT '保留8',
  `attribute9` text COMMENT '保留9',
  `attribute10` text COMMENT '保留10',
  PRIMARY KEY (`row_id`) USING BTREE,
  KEY `unq_t_ldm_base_dict_opt_u1` (`dict_row_id`,`key`,`lang`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='通用数据字典选项定义';

-- ----------------------------
-- Table structure for t_ldm_base_dictionary_def
-- ----------------------------
CREATE TABLE `t_ldm_base_dictionary_def` (
  `row_id` varchar(64) NOT NULL COMMENT '数据字典主键',
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `dict_code` varchar(256) DEFAULT NULL COMMENT '字典代码',
  `dict_name` varchar(256) DEFAULT NULL COMMENT '字典名称',
  `code_type` varchar(64) DEFAULT NULL COMMENT '字典值类型: ,string:字符串,integer:整数,number:小数,time:时分秒（HH:mm:ss）,date:年月日（yyyy-MM-dd）,longDateTime:日期（yyyy-MM-dd HH:mm:ss）,regex:正则表达式',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `role_name` varchar(32) DEFAULT NULL COMMENT '数据字典权限',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`row_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_dict_u1` (`site_id`,`dict_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='数据字典';

-- ----------------------------
-- Table structure for t_ldm_base_elc_map
-- ----------------------------
CREATE TABLE `t_ldm_base_elc_map` (
  `warehouse_id` varchar(64) DEFAULT NULL COMMENT '逻辑仓库ID',
  `map_code` varchar(64) NOT NULL COMMENT '电子地图主键',
  `map_name` varchar(64) DEFAULT NULL COMMENT '电子地图名称',
  `map_short_name` varchar(32) DEFAULT NULL COMMENT '电子地图简称',
  `map_type_code` varchar(2) NOT NULL COMMENT '地图类型（1-栅格；2-拓扑；3-外部）',
  `row_count` int DEFAULT NULL COMMENT '栅格地图-行数',
  `col_count` int DEFAULT NULL COMMENT '栅格地图-列数',
  `order_by` int DEFAULT NULL COMMENT '排序',
  `content` longtext COMMENT '地图内容',
  `ground_type_code` varchar(3) NOT NULL COMMENT '地码编号',
  `shelf_angle` varchar(4) DEFAULT NULL COMMENT '货架相对地图的方向，栅格地图',
  `width` int DEFAULT NULL COMMENT '每格宽度',
  `height` int DEFAULT NULL COMMENT '每格高度',
  `img_extension` varchar(64) DEFAULT NULL COMMENT '背景图文件扩展名',
  `img_source_file` longblob COMMENT '背景图文件',
  `act_under_shelf` varchar(2) DEFAULT NULL COMMENT '拓扑地图小车进入货架方式',
  `building_floor` varchar(64) DEFAULT NULL COMMENT '楼层',
  `lock_ip` varchar(32) DEFAULT NULL COMMENT '地图当前编辑人IP',
  `count` int DEFAULT NULL COMMENT '同一个session锁定次数',
  `version_id` int DEFAULT NULL COMMENT '版本ID，创建和提交时',
  `refresh_map_flag` varchar(2) DEFAULT NULL COMMENT '是否刷新地图标识. 0/1',
  `shelf_dir_conf` varchar(2) DEFAULT NULL COMMENT '载具方向配置',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `background_data` longtext COMMENT '客户端地图背景数据XML',
  `map_angle` int DEFAULT NULL COMMENT '地图角度',
  PRIMARY KEY (`map_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子地图';

-- ----------------------------
-- Table structure for t_ldm_base_elc_map_his
-- ----------------------------
CREATE TABLE `t_ldm_base_elc_map_his` (
  `map_his_id` varchar(64) NOT NULL COMMENT '编号',
  `map_his_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `map_his_content` longtext COMMENT '地图内容',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `backup_date` datetime DEFAULT NULL COMMENT '归档时间',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`map_his_id`) USING BTREE,
  KEY `idx_maphis_crd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子地图历史表';

-- ----------------------------
-- Table structure for t_ldm_base_map_data
-- ----------------------------
CREATE TABLE `t_ldm_base_map_data` (
  `map_data_code` varchar(64) NOT NULL COMMENT '地图数据编号',
  `map_data_name` varchar(64) DEFAULT NULL COMMENT '地图数据名称',
  `map_element_code` varchar(64) DEFAULT NULL COMMENT '地图元素类型',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `coo_x` decimal(10,3) DEFAULT NULL COMMENT 'X坐标',
  `coo_y` decimal(10,3) DEFAULT NULL COMMENT 'Y坐标',
  `direction` varchar(4) DEFAULT NULL COMMENT '方向',
  `frequence_property` bigint DEFAULT NULL COMMENT '物料高低频:10-高高频;30-高频;50-低频. default 50',
  `epa_flag` varchar(1) DEFAULT NULL COMMENT '默认N,静电区标识;Y:静电区EPA,N:非静电区NEPA',
  `support_device_type` text COMMENT '支持的设备类型（用半角逗号隔开）',
  `status` smallint DEFAULT NULL COMMENT '状态（1-启用；0-禁用——禁入不禁出）',
  `device_code` varchar(64) DEFAULT NULL COMMENT '当前设备编号',
  `shelf_id` varchar(64) DEFAULT NULL COMMENT '货架/载具ID',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `shelf_direction` varchar(4) DEFAULT NULL COMMENT '当前载具方向',
  `lock_flag` varchar(1) DEFAULT NULL COMMENT '锁定标识（推荐货位锁定）',
  `lock_by` varchar(32) DEFAULT NULL COMMENT '锁定源（指令ID）',
  `berth_type` varchar(2) DEFAULT NULL COMMENT '内外层属性（1:外层、2:内层、3:普通）',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编号',
  `lift_height` decimal(10,3) DEFAULT NULL COMMENT '举升高度（单位：MM）',
  `related_map_data_code` varchar(64) DEFAULT NULL COMMENT '关联地图数据编号',
  `related_area_code` varchar(64) DEFAULT NULL COMMENT '关联区域',
  `related_shelf_type` varchar(16) DEFAULT NULL COMMENT '关联货架类型',
  `charge_device_type` text COMMENT '充电桩支持车型（多车型半角逗号隔开）',
  `road_id` varchar(64) DEFAULT NULL COMMENT '通道ID',
  `road_no` int DEFAULT NULL COMMENT '通道编号',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `pick_direction` varchar(4) DEFAULT NULL COMMENT '拣货方向',
  `queue_number` smallint DEFAULT NULL COMMENT '货位容量(含地码上的载具)',
  `map_data_type` varchar(64) DEFAULT NULL COMMENT '货位类型',
  `outer_device_code` varchar(64) DEFAULT NULL COMMENT '外接设备编号',
  `outer_device_group` varchar(64) DEFAULT NULL COMMENT '外接设备分组名(同组同区域)',
  `shelf_type_group` varchar(64) DEFAULT NULL COMMENT '货架/载具组，将具体相同属性的载具组合，用于货位可存储的载具组。为空时允许所有类型载具存储',
  `storage_updated_date` datetime DEFAULT NULL COMMENT '库存更新时间（载具绑定解绑货位时更新时间）',
  `map_data_sort` smallint DEFAULT NULL COMMENT '货位排序',
  `in_out_type` smallint DEFAULT NULL COMMENT '货位出入类型（0:可入可出,1：只允许入,2：只允许出）',
  `stationed_flag` varchar(2) DEFAULT NULL COMMENT '是否可暂驻(0：不可暂驻；1：可暂驻)',
  `io_device_code` varchar(32) DEFAULT NULL COMMENT 'IO设备编号',
  `update_map` varchar(1) DEFAULT NULL COMMENT '是否刷地图标识:0/1',
  `map_data_empty_date` datetime DEFAULT NULL COMMENT '载具从该货位离开时间',
  PRIMARY KEY (`map_data_code`) USING BTREE,
  KEY `idx_base_map_data_arco` (`area_code`) USING BTREE,
  KEY `n_t_ldm_base_map_data_n1` (`shelf_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='电子地图数据';

-- ----------------------------
-- Table structure for t_ldm_base_map_data_rel
-- ----------------------------
CREATE TABLE `t_ldm_base_map_data_rel` (
  `map_data_rel_id` varchar(64) NOT NULL COMMENT '地图元素关联关系',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编号',
  `map_data_code` varchar(64) DEFAULT NULL COMMENT '地图数据编号',
  `map_element_type` varchar(64) DEFAULT NULL COMMENT '地图元素类型',
  `related_map_data_code` varchar(64) DEFAULT NULL COMMENT '关联地图数据编号',
  `related_map_element_type` varchar(64) DEFAULT NULL COMMENT '关联地图元素类型',
  `related_type` varchar(2) DEFAULT NULL COMMENT '关联类型(1-内关联外，2-外关联内)',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`map_data_rel_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='地图数据关联关系';

-- ----------------------------
-- Table structure for t_ldm_base_map_element_conf
-- ----------------------------
CREATE TABLE `t_ldm_base_map_element_conf` (
  `map_element_code` varchar(64) NOT NULL COMMENT '地图元素编号',
  `map_element_type` varchar(64) DEFAULT NULL COMMENT '地图元素类型',
  `map_element_type_name` varchar(64) DEFAULT NULL COMMENT '地图元素名称',
  `map_element_category` varchar(2) DEFAULT NULL COMMENT '分类(0:基础元素;1:业务元素)',
  `default_flag` varchar(1) DEFAULT NULL COMMENT '是否默认 Y/N',
  `display_flag` varchar(2) DEFAULT NULL COMMENT '是否显示',
  `parse_flag` varchar(2) DEFAULT NULL COMMENT '是否解析',
  `seq_max` bigint DEFAULT NULL COMMENT '最大排队数',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp(6) NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp(6) NULL DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`map_element_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='地图元素类型';

-- ----------------------------
-- Table structure for t_ldm_base_msg_temp
-- ----------------------------
CREATE TABLE `t_ldm_base_msg_temp` (
  `msg_temp_code` varchar(64) NOT NULL COMMENT '报文编号',
  `msg_temp_name` text COMMENT '报文名称',
  `msg_temp_type` varchar(2) DEFAULT NULL COMMENT '报文类型',
  `send_msg` text COMMENT '下发报文',
  `rcv_msg` text COMMENT '接收报文',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`msg_temp_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='消息报文模板';

-- ----------------------------
-- Table structure for t_ldm_base_pallet
-- ----------------------------
CREATE TABLE `t_ldm_base_pallet` (
  `pallet_id` varchar(64) NOT NULL COMMENT '栈板ID',
  `pallet_code` varchar(64) DEFAULT NULL COMMENT '栈板编号',
  `item_code` varchar(64) DEFAULT NULL COMMENT '物料编码',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`pallet_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_pallet_u1` (`pallet_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='货架/载具表';

-- ----------------------------
-- Table structure for t_ldm_base_road
-- ----------------------------
CREATE TABLE `t_ldm_base_road` (
  `road_id` varchar(64) NOT NULL COMMENT '通道ID',
  `road_no` int DEFAULT NULL COMMENT '通道编号',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编号',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '有效标识:Y/N,默认Y',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `road_name` text COMMENT '巷道名称',
  `lock_flag` varchar(1) DEFAULT NULL COMMENT '锁定标识:Y(锁定)/(未锁),默认N',
  `io_device_code` varchar(32) DEFAULT NULL COMMENT 'IO设备编号',
  PRIMARY KEY (`road_id`) USING BTREE,
  KEY `n_t_ldm_base_road_n1` (`area_code`) USING BTREE,
  KEY `n_t_ldm_base_road_n2` (`road_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='巷道基表';

-- ----------------------------
-- Table structure for t_ldm_base_server
-- ----------------------------
CREATE TABLE `t_ldm_base_server` (
  `server_id` varchar(64) NOT NULL COMMENT '服务ID',
  `server_name` varchar(256) DEFAULT NULL COMMENT '服务名称',
  `server_type_code` varchar(16) DEFAULT NULL COMMENT '服务类型（RCS，AMS，WCS，OTHER）',
  `alarm_server_id` varchar(64) DEFAULT NULL COMMENT '告警服务ID',
  `server_ip` varchar(32) DEFAULT NULL COMMENT 'IP地址',
  `server_port` bigint DEFAULT NULL COMMENT 'IP端口号',
  `server_url` varchar(256) DEFAULT NULL COMMENT '服务URL',
  `remote_conf_param` longtext COMMENT '远程配置参数（报文）',
  `udp_port` bigint DEFAULT NULL COMMENT 'UDP端口',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` longtext COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `ai_server_id` varchar(64) DEFAULT NULL COMMENT 'AI服务ID',
  `alg_server_url` varchar(256) DEFAULT NULL COMMENT 'ALG算法服务URL',
  PRIMARY KEY (`server_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='RCS系统服务表';

-- ----------------------------
-- Table structure for t_ldm_base_server_map_detail
-- ----------------------------
CREATE TABLE `t_ldm_base_server_map_detail` (
  `server_map_detail_id` varchar(64) NOT NULL COMMENT '主键',
  `server_id` varchar(64) NOT NULL COMMENT '服务ID',
  `warehouse_id` varchar(64) DEFAULT NULL COMMENT '逻辑仓库ID',
  `map_code` varchar(64) DEFAULT NULL COMMENT '地图编码',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`server_map_detail_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务地图明细';

-- ----------------------------
-- Table structure for t_ldm_base_shelf
-- ----------------------------
CREATE TABLE `t_ldm_base_shelf` (
  `shelf_id` varchar(64) NOT NULL COMMENT '货架/载具ID',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `shelf_name` text COMMENT '货架/载具描述',
  `shelf_type_id` varchar(64) DEFAULT NULL COMMENT '货架/载具类型ID',
  `shelf_type_code` varchar(64) DEFAULT NULL COMMENT '货架/载具类型编码',
  `warehouse_id` varchar(64) NOT NULL COMMENT '逻辑仓库ID  ',
  `warehouse_code` varchar(64) DEFAULT NULL COMMENT '逻辑仓库编码',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编号',
  `ptl_device_id` varchar(32) DEFAULT NULL COMMENT 'PTL设备ID',
  `system_lock_flag` varchar(1) DEFAULT NULL COMMENT '系统锁定标识 Y/N：默认N',
  `user_lock_flag` varchar(1) DEFAULT NULL COMMENT '用户锁定标识  Y/N：默认N',
  `user_lock_reason` text COMMENT '用户锁定原因',
  `user_lock_by` varchar(32) DEFAULT NULL COMMENT '锁定人',
  `user_lock_by_name` varchar(32) DEFAULT NULL COMMENT '锁定人姓名',
  `user_lock_date` datetime DEFAULT NULL COMMENT '锁定时间',
  `map_data_code` varchar(64) DEFAULT NULL COMMENT '地图数据编号',
  `initial_status` smallint DEFAULT NULL COMMENT '初始化状态标识（未初始化0，正在初始化1，初始化完成2）',
  `src_map_data_code` varchar(64) DEFAULT NULL COMMENT '起始储位编号',
  `lpn_qty` bigint DEFAULT NULL COMMENT 'LPN数量（0即空载具，非0非空载具）',
  `goods_net_weight` decimal(10,3) DEFAULT NULL COMMENT '货物净重（单位：KG）',
  `goods_length` decimal(10,3) DEFAULT NULL COMMENT '货物长度（单位：MM）',
  `goods_width` decimal(10,3) DEFAULT NULL COMMENT '货物宽度（单位：MM）',
  `goods_height` decimal(10,3) DEFAULT NULL COMMENT '货物高度（单位：MM）',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `lpn_remark` text COMMENT '交付对象',
  PRIMARY KEY (`shelf_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_shelf_u1` (`shelf_code`) USING BTREE,
  KEY `idx_t_ldm_base_shelf_u2` (`map_data_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='货架/载具表';

-- ----------------------------
-- Table structure for t_ldm_base_shelf_type
-- ----------------------------
CREATE TABLE `t_ldm_base_shelf_type` (
  `shelf_type_id` varchar(64) NOT NULL COMMENT '货架/载具类型ID',
  `shelf_type_code` varchar(64) DEFAULT NULL COMMENT '货架/载具类型编码',
  `shelf_type_name` varchar(255) DEFAULT NULL COMMENT '货架/载具名称',
  `shelf_weight` decimal(10,3) DEFAULT NULL COMMENT '货架/载具自重',
  `shelf_length` decimal(10,3) DEFAULT NULL COMMENT '货架/载具长（单位：MM）',
  `shelf_width` decimal(10,3) DEFAULT NULL COMMENT '货架/载具宽（单位：MM）',
  `shelf_height` decimal(10,3) DEFAULT NULL COMMENT '货架/载具高（单位：MM）',
  `shelf_layer` smallint DEFAULT NULL COMMENT '层数',
  `lpn_capacity` bigint DEFAULT NULL COMMENT '货架/载具容量（单位：pcs）',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `shelf_category` varchar(64) DEFAULT NULL COMMENT '货架/载具种类（长方向货架、正方形货架、长方向托盘、正方形托盘）',
  `shelf_type_group` varchar(64) DEFAULT NULL COMMENT '货架/载具组，将具体相同属性的载具组合，用于货位可存储的载具组。',
  `shelf_leg_height` decimal(10,3) DEFAULT NULL COMMENT '货架/载具腿高（单位：MM）',
  `shelf_property` varchar(2) DEFAULT NULL COMMENT '货架属性（1：实物载具；2：虚拟载具）',
  `has_frame_flag` varchar(1) DEFAULT NULL COMMENT '是否有框体（有框体：Y，无框体：N）',
  `algm_pod_type` smallint DEFAULT NULL COMMENT '载具穿行方式（0：货架底下任意穿行 1：货架底下不能旋转  2：不能从货架短边进入  3：既不能从货架短边进入又不能在货架底下转 4：正方形货架 5：盲举',
  PRIMARY KEY (`shelf_type_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_shelf_type_u1` (`shelf_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='货架/载具类型';

-- ----------------------------
-- Table structure for t_ldm_base_shelf_type_detail
-- ----------------------------
CREATE TABLE `t_ldm_base_shelf_type_detail` (
  `shelf_type_detail_id` varchar(64) DEFAULT NULL COMMENT '主键',
  `stg_bin_type_id` varchar(64) DEFAULT NULL COMMENT '仓位类型ID',
  `shelf_type_id` varchar(64) DEFAULT NULL COMMENT '货架/载具类型ID',
  `direction_code` varchar(2) DEFAULT NULL COMMENT '方向（1东 2南 3西 4北 5中）',
  `layer_num` smallint DEFAULT NULL COMMENT '第几层',
  `bin_num` smallint DEFAULT NULL COMMENT '第几格',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `pallet_identify_flag` varchar(1) DEFAULT NULL COMMENT '栈板识别标识（Y/N,Y开启，N关闭，默认为N）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='货架/载具类型详情';

-- ----------------------------
-- Table structure for t_ldm_base_sps_ability
-- ----------------------------
CREATE TABLE `t_ldm_base_sps_ability` (
  `sps_ability_id` varchar(64) NOT NULL COMMENT '特殊设备能力ID',
  `ability_group_code` varchar(64) DEFAULT NULL COMMENT '设备能力组编号',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '来源区域编号',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标区域编号',
  `ability_priority` bigint DEFAULT NULL COMMENT '设备能力优先级（默认99）',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`sps_ability_id`) USING BTREE,
  KEY `t_ldm_base_sps_abt_area` (`from_area_code`,`to_area_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='特殊设备设备能力';

-- ----------------------------
-- Table structure for t_ldm_base_stg_bin
-- ----------------------------
CREATE TABLE `t_ldm_base_stg_bin` (
  `stg_bin_id` varchar(64) NOT NULL COMMENT '仓位ID',
  `stg_bin_code` varchar(64) DEFAULT NULL COMMENT '仓位编号',
  `stg_bin_type_id` varchar(64) DEFAULT NULL COMMENT '仓位类型ID',
  `stg_bin_type_code` varchar(64) DEFAULT NULL COMMENT '仓位类型编号',
  `warehouse_id` varchar(64) NOT NULL COMMENT '逻辑仓库ID',
  `warehouse_code` varchar(64) NOT NULL COMMENT '逻辑仓库编码',
  `pallet_code` text COMMENT '存储栈板编号（多层货架不记录）',
  `shelf_id` varchar(64) DEFAULT NULL COMMENT '货架/载具ID',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `ptl_tag_id` varchar(32) DEFAULT NULL COMMENT 'PTL标签ID',
  `direction_code` varchar(2) DEFAULT NULL COMMENT '方向（1东,2南,3西,4北,5中）',
  `layer_num` bigint DEFAULT NULL COMMENT '层',
  `bin_num` bigint DEFAULT NULL COMMENT '格',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `lock_flag` varchar(1) DEFAULT NULL COMMENT '锁定标识（仓位锁定）(Y/N,默认为N)',
  `lock_by` varchar(64) DEFAULT NULL COMMENT '锁定源（指令ID）',
  `stg_bin_mapping_code` varchar(64) DEFAULT NULL COMMENT '业务对应的仓位编码',
  `fork_bin_height` decimal(10,2) DEFAULT NULL COMMENT '叉车全向车虚拟货架仓位高度',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`stg_bin_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_stg_bin_u1_copy1` (`stg_bin_code`) USING BTREE,
  KEY `idx_base_stg_bin_shelfid_copy1` (`shelf_id`) USING BTREE,
  KEY `idx_ldm_stg_bin_scod_copy1` (`shelf_code`) USING BTREE,
  KEY `n_t_ldm_base_stg_bin_n2_copy1` (`stg_bin_mapping_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='仓位信息';

-- ----------------------------
-- Table structure for t_ldm_base_stg_bin_type
-- ----------------------------
CREATE TABLE `t_ldm_base_stg_bin_type` (
  `stg_bin_type_id` varchar(64) NOT NULL COMMENT '仓位类型ID',
  `stg_bin_type_code` varchar(64) DEFAULT NULL COMMENT '仓位类型编号',
  `stg_bin_type_name` text COMMENT '仓位类型名称',
  `stg_bin_length` decimal(10,3) DEFAULT NULL COMMENT '仓位类型长（单位：MM）',
  `stg_bin_width` decimal(10,3) DEFAULT NULL COMMENT '仓位类型宽（单位：MM）',
  `stg_bin_height` decimal(10,3) DEFAULT NULL COMMENT '仓位类型高（单位：MM）',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效 Y/N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `stg_bin_weight` decimal(10,3) DEFAULT NULL COMMENT '仓位类型限重（单位：MM）',
  `full_fork_height` decimal(10,3) DEFAULT NULL COMMENT '仓位类型满叉高度（单位：MM）',
  `empty_fork_height` decimal(10,3) DEFAULT NULL COMMENT '仓位类型空叉高度（单位：MM）',
  `storage_type` varchar(1) DEFAULT NULL COMMENT '存放类型0/1（1 放铁托盘，关激光 0 放地面，不关激光）',
  `carry_walk_height` decimal(10,3) DEFAULT NULL COMMENT '货架行走高度',
  `custom_properties` text COMMENT '自定义属性',
  PRIMARY KEY (`stg_bin_type_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_stg_bin_type_u1_copy1` (`stg_bin_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='仓位类型';

-- ----------------------------
-- Table structure for t_ldm_base_warehouse
-- ----------------------------
CREATE TABLE `t_ldm_base_warehouse` (
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `warehouse_id` varchar(64) NOT NULL COMMENT '逻辑仓库ID  由GUID生成',
  `warehouse_code` varchar(64) DEFAULT NULL COMMENT '逻辑仓库编码',
  `warehouse_name` varchar(128) DEFAULT NULL COMMENT '逻辑仓库名称',
  `warehouse_address` varchar(256) DEFAULT NULL COMMENT '逻辑仓库位置',
  `warehouse_ai_url` varchar(256) DEFAULT NULL COMMENT '逻辑仓库服务AI地址',
  `warehouse_core_url` varchar(256) DEFAULT NULL COMMENT '逻辑仓库服务CORE地址',
  `warehouse_base_url` varchar(256) DEFAULT NULL COMMENT '逻辑仓库服务BASE地址',
  `valid_flag` varchar(1) DEFAULT 'Y' COMMENT '是否有效 Y/N',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `warehouse_wtsm_url` varchar(256) DEFAULT NULL COMMENT '逻辑仓库服务WTSM地址',
  PRIMARY KEY (`warehouse_id`) USING BTREE,
  UNIQUE KEY `unq_t_ldm_base_wh_u1` (`warehouse_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='仓库表';

-- ----------------------------
-- Table structure for t_ldm_core_assign_map_data
-- ----------------------------
CREATE TABLE `t_ldm_core_assign_map_data` (
  `map_data_assign_id` varchar(64) NOT NULL COMMENT '主键，UUID',
  `task_id` varchar(64) DEFAULT NULL COMMENT '配送任务ID',
  `command_id` varchar(64) DEFAULT NULL COMMENT '指令ID',
  `old_command_id` varchar(64) DEFAULT NULL,
  `assign_type` decimal(65,30) DEFAULT NULL COMMENT '建议类型：1=assignMapDataCode(预占目的货位)；2=assignStartOutMapDataCode(预占起点外层货位)；3=assignEndOutMapDataCode(预占终点外层货位)',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架编码',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编码',
  `map_data_code` varchar(64) DEFAULT NULL COMMENT '货位编码',
  `assign_status` decimal(65,30) DEFAULT NULL COMMENT '推荐货位状态：0=预占；1=释放；默认为0',
  `area_code_temp` varchar(64) DEFAULT NULL COMMENT '上下架暂存区区域编码',
  `map_data_code_temp` varchar(64) DEFAULT NULL COMMENT '上下架暂存区货位编码',
  `assign_status_temp` decimal(65,30) DEFAULT NULL COMMENT '上下架暂存区推荐货位状态：0=预占；1=释放；默认为0',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `map_data_type` varchar(64) DEFAULT NULL COMMENT '货位类型',
  PRIMARY KEY (`map_data_assign_id`) USING BTREE,
  KEY `idx_assign_map_acode_astat` (`area_code`,`assign_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='推荐货位表';

-- ----------------------------
-- Table structure for t_ldm_core_assign_shelf
-- ----------------------------
CREATE TABLE `t_ldm_core_assign_shelf` (
  `shelf_assign_id` varchar(64) NOT NULL COMMENT '表主键，UUID',
  `task_id` varchar(64) DEFAULT NULL COMMENT '配送任务ID',
  `command_id` varchar(64) DEFAULT NULL COMMENT '指令ID',
  `shelf_id` varchar(64) DEFAULT NULL COMMENT '货架/载具ID',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `assign_status` decimal(65,30) DEFAULT NULL COMMENT '推荐载具状态：0=预占；1=释放；默认为0',
  `area_code` varchar(64) DEFAULT NULL COMMENT '区域编码',
  `map_data_code` varchar(64) DEFAULT NULL COMMENT '货位编码',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`shelf_assign_id`) USING BTREE,
  KEY `idx_t_core_assign_shelf_n1` (`area_code`,`assign_status`) USING BTREE,
  KEY `idx_tldm_core_assgsf_crd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='推荐空载具表';

-- ----------------------------
-- Table structure for t_ldm_core_command
-- ----------------------------
CREATE TABLE `t_ldm_core_command` (
  `command_id` varchar(64) NOT NULL COMMENT '指令ID',
  `task_id` varchar(64) DEFAULT NULL COMMENT '配送任务ID',
  `task_type` varchar(32) DEFAULT NULL COMMENT '任务类型(约定，包括WMS发起，与MLM发起，设备发起)',
  `command_status` smallint DEFAULT NULL COMMENT '指令状态（10初始/20已选车/30下发成功/31下发失败/40已启动/50执行中(顶升)/55执行中(离开储位）/60已完成/800正在取消/899取消待重发/900取消完成）',
  `dispatch_flag` varchar(1) DEFAULT NULL COMMENT '指令可分配标识Y/N',
  `split_l_id` varchar(64) DEFAULT NULL COMMENT '指令拆分行ID（序列）',
  `split_h_id` varchar(64) DEFAULT NULL COMMENT '指令拆分头ID',
  `command_no` smallint DEFAULT NULL COMMENT '指令序号（同SPLIT_H_ID下指令的排列序号）',
  `same_agv_grp_id` bigint DEFAULT NULL COMMENT '下发到相同AGV分组ID（序列）',
  `command_type` varchar(32) DEFAULT NULL COMMENT '指令类型（MOVE行走/DELIVERY搬运/RECHARGE充电/ROTATE旋转）',
  `business_type` varchar(32) DEFAULT NULL COMMENT '业务类型',
  `command_desc` text COMMENT '指令描述',
  `pre_trigger_mode` smallint DEFAULT NULL COMMENT '指令前置触发模式（1=直接触发（默认）/2=关联指令状态触发/3=关联指令完成延时触发\r\n/4=前置事件触发）',
  `pre_command_no` smallint DEFAULT NULL COMMENT '关联指令状态触发指令序号（仅关联指令触发模式下生效）',
  `pre_event_code` varchar(64) DEFAULT NULL COMMENT '前置事件触发事件代码（仅事件触发模式下生效）',
  `pre_timer_set` smallint DEFAULT NULL COMMENT '关联指令完成延时触发时间（秒），按指令完成时间计算',
  `suf_event_code` text COMMENT '后置驱动事件代码（支持多个事件逗号隔开，排序先后为优先级，数据字典控制最大事件数）',
  `real_pre_erecord_id` smallint DEFAULT NULL COMMENT '实际前置触发事件行ID',
  `agv_lift_start_flag` varchar(2) DEFAULT NULL COMMENT '指令开始后AGV举升标识（Y举升/N放下/B保持）',
  `agv_lift_end_flag` varchar(2) DEFAULT NULL COMMENT '指令完成后AGV举升标识（Y举升/N放下）',
  `occupied_alarm_flag` varchar(2) DEFAULT NULL COMMENT '目的位置被占用是否报警标识(Y报警/N不报警)，停用',
  `check_lpn_flag` varchar(2) DEFAULT NULL COMMENT '是否校验LPN（Y/N）',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `shelf_direction` varchar(64) DEFAULT NULL COMMENT '当前载具方向',
  `cancel_reason_code` text COMMENT '指令取消原因代码',
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `device_type_code` varchar(64) DEFAULT NULL COMMENT '设备类型编号',
  `keep_shelf` varchar(2) DEFAULT NULL COMMENT '是否记录货架位置',
  `device_direction` varchar(64) DEFAULT NULL COMMENT '设备方向（“180”,”0”,”90”,”-90” 分别代表”左”,”右”,”上”,”下”(“999”-系统自己控制)）',
  `round_degree` varchar(4) DEFAULT NULL COMMENT '旋转度数',
  `command_change_date` datetime DEFAULT NULL COMMENT '指令变更时间',
  `from_area_id` varchar(64) DEFAULT NULL COMMENT '源货区ID',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `from_area_building_floor` varchar(64) DEFAULT NULL COMMENT '来源区域楼层',
  `from_map_code` varchar(64) DEFAULT NULL COMMENT '源地图编号',
  `from_map_data_code` varchar(64) DEFAULT NULL COMMENT '源货位',
  `start_x` decimal(10,3) DEFAULT NULL COMMENT '起点X',
  `start_y` decimal(10,3) DEFAULT NULL COMMENT '起点Y',
  `re_start_x` decimal(10,3) DEFAULT NULL COMMENT '重发起点X',
  `re_start_y` decimal(10,3) DEFAULT NULL COMMENT '重发起点Y',
  `end_x` decimal(10,3) DEFAULT NULL COMMENT '终点X',
  `end_y` decimal(10,3) DEFAULT NULL COMMENT '终点Y',
  `to_area_id` varchar(64) DEFAULT NULL COMMENT '目标货区ID',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标货区代码',
  `to_map_code` varchar(64) DEFAULT NULL COMMENT '目标地图编号',
  `to_map_data_type` varchar(64) DEFAULT NULL COMMENT '目标货位类型',
  `to_map_data_code` varchar(64) DEFAULT NULL COMMENT '目标货位',
  `process_by` varchar(32) DEFAULT NULL COMMENT '处理服务器名称或IP',
  `process_status` bigint DEFAULT NULL COMMENT '处理状态（10初始 20处理中 30处理成功 40处理失败 900取消）',
  `process_times` bigint DEFAULT NULL COMMENT '处理次数（默认为0）',
  `process_error_message` text COMMENT '处理失败信息',
  `command_delivery_times` bigint DEFAULT NULL COMMENT '下发次数（默认为0）',
  `dense_command_id` varchar(64) DEFAULT NULL COMMENT '密集存储指令主ID号（里层的指令）',
  `task_msg` text COMMENT '消息报文',
  `need_confirm` varchar(2) DEFAULT NULL COMMENT '是否需要确认',
  `stay_time` bigint DEFAULT NULL COMMENT '停留时间',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `cancel_command_id` varchar(64) DEFAULT NULL COMMENT '关联被取消的指令单号',
  `cancel_type` varchar(2) DEFAULT NULL COMMENT '取消类型1.单据引起的任务取消；2.监控、平台取消子任务',
  `cancel_date` datetime DEFAULT NULL COMMENT '指令取消时间',
  `change_reason_code` text COMMENT '指令变更原因代码',
  `pre_command_status` smallint DEFAULT NULL COMMENT '关联指令状态触发的指令状态（10初始/20已选车/30下发成功/31下发失败/40已启动/50执行中(顶升)/55执行中(离开储位）/60已完成/800正在取消/899取消待重发/900取消完成）',
  `before_command_status` smallint DEFAULT NULL COMMENT '取消前的指令状态（10初始/20已选车/30下发成功/31下发失败/40已启动/50执行中(顶升)/55执行中(离开储位）/60已完成/800正在取消/899取消待重发/900取消完成）',
  `to_area_building_floor` varchar(64) DEFAULT NULL COMMENT '目标区域楼层',
  `frequence` bigint DEFAULT NULL COMMENT '物料高低频:10-高高频;30-高频;50-低频.',
  `can_overlap_flag` varchar(2) DEFAULT NULL COMMENT 'AGV分段式配送可跳过标识',
  `can_overlap_cmd_no` smallint DEFAULT NULL COMMENT '指令可跳过关联指令编号',
  `assign_locator_strategy` smallint DEFAULT NULL COMMENT '建议货位策略：1=就近建议货位；2=就远建议货位；3=上架优先级建议货位；默认为1，策略为空时，默认为1',
  `shelf_type_code` varchar(64) DEFAULT NULL COMMENT '载具类型',
  `side_code` varchar(10) DEFAULT NULL COMMENT 'AB面（只适用于多层货架模式）',
  `from_area_storage_mode` smallint DEFAULT NULL COMMENT '源区域存放方式(1：载具；2：栈板）',
  `to_area_storage_mode` smallint DEFAULT NULL COMMENT '目标区域存放方式(1：载具；2：栈板）',
  `cargo_height` decimal(10,3) DEFAULT NULL COMMENT '货物高度',
  `from_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '来源仓位',
  `to_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '目标仓位',
  `pallet_code` varchar(64) DEFAULT NULL COMMENT '栈板编号',
  `cargo_weight` decimal(10,3) DEFAULT NULL COMMENT '货物重量',
  `link_command_id` varchar(64) DEFAULT NULL COMMENT '衔接指令ID',
  `link_area_code` varchar(64) DEFAULT NULL COMMENT '衔接指令源区域',
  `link_timeout` decimal(65,30) DEFAULT NULL COMMENT '衔接指令超时时间设置(单位：S)',
  `same_lpn_group_id` bigint DEFAULT NULL COMMENT 'ELT_ONE多指令同组搬运对象',
  `stock_result` varchar(64) DEFAULT NULL COMMENT '盘点结果',
  `auto_check_direction` varchar(8) DEFAULT NULL COMMENT '自动点检指令旋转方向',
  `auto_check_sensor_type` smallint DEFAULT NULL COMMENT '自动点检传感器类型',
  `agv_delay_waiting_time` decimal(65,30) DEFAULT NULL COMMENT 'agv延时等待时间(单位：S)',
  `stay_flag` varchar(1) DEFAULT NULL COMMENT 'agv指令完成保持标识（Y/N）',
  PRIMARY KEY (`command_id`) USING BTREE,
  KEY `command_mix_index` (`command_status`,`to_area_code`,`creation_date`) USING BTREE,
  KEY `idx_core_command_shelf_code` (`shelf_code`) USING BTREE,
  KEY `idx_tldm_core_command_lsd` (`last_updated_date`) USING BTREE,
  KEY `n_t_ldm_core_command_n1` (`task_id`) USING BTREE,
  KEY `n_t_ldm_core_command_n3` (`pallet_code`) USING BTREE,
  KEY `n_tldm_core_command_cd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='子任务单';

-- ----------------------------
-- Table structure for t_ldm_core_command_ext
-- ----------------------------
CREATE TABLE `t_ldm_core_command_ext` (
  `command_id` varchar(64) NOT NULL COMMENT '指令ID',
  `real_sending_date` datetime DEFAULT NULL COMMENT '指令实际下发时间',
  `real_receive_date` datetime DEFAULT NULL COMMENT '指令实际接收时间',
  `last_refuse_date` datetime DEFAULT NULL COMMENT '最后拒绝时间',
  `last_refuse_code` varchar(64) DEFAULT NULL COMMENT '最后指令拒绝原因代码（路径规划失败等）',
  `real_start_date` datetime DEFAULT NULL COMMENT '指令实际启动时间（前往起始点）',
  `arrival_start_date` datetime DEFAULT NULL COMMENT '到达起始点时间',
  `leave_start_date` datetime DEFAULT NULL COMMENT '离开起始点时间',
  `command_distance` bigint DEFAULT NULL COMMENT '指令执行实际路程长度m',
  `chg_device_date` datetime DEFAULT NULL COMMENT '换车时间',
  `arrival_end_date` datetime DEFAULT NULL COMMENT '指令实际完成时间（到达终点）',
  `pre_distance` bigint DEFAULT NULL COMMENT '前往起始点实际路程长度m（空跑里程）',
  `start_bat` bigint DEFAULT NULL COMMENT '任务开始小车实时电量',
  `end_bat` bigint DEFAULT NULL COMMENT '任务完成小车实时电量',
  `start_mile` bigint DEFAULT NULL COMMENT '任务开始小车实时里程数m',
  `end_mile` bigint DEFAULT NULL COMMENT '任务完成小车实时里程数m',
  `charge_time` bigint DEFAULT NULL COMMENT '充电时差',
  `re_start_send_flag` bigint DEFAULT NULL COMMENT '循环找位置，重启发送标识',
  `plan_use_time` bigint DEFAULT NULL COMMENT '预计耗时s（总路程除以标准速度,更新路程时刷新，同时刷预计完成时间）',
  `remark` text COMMENT '备注',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `lift_bat` bigint DEFAULT NULL COMMENT '任务举升小车实时电量',
  `lift_mile` bigint DEFAULT NULL COMMENT '任务举升小车实时里程数m  ',
  `free_running_time_span` bigint DEFAULT NULL COMMENT 'AGV空跑时间',
  `execute_time_span` bigint DEFAULT NULL COMMENT 'AGV执行时间',
  PRIMARY KEY (`command_id`) USING BTREE,
  KEY `idx_tldmcore_comand_ext_lsd` (`last_updated_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='子任务单扩展表（记录指令实际执行信息）';

-- ----------------------------
-- Table structure for t_ldm_core_event_info
-- ----------------------------
CREATE TABLE `t_ldm_core_event_info` (
  `event_id` varchar(64) NOT NULL COMMENT '事件ID（UUID）',
  `req_code` varchar(64) DEFAULT NULL COMMENT '请求编号',
  `req_time` varchar(64) DEFAULT NULL COMMENT '请求时间',
  `event_code` varchar(64) DEFAULT NULL COMMENT '事件代码',
  `event_type` text COMMENT '事件类型',
  `source_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `event_device_type` varchar(64) DEFAULT NULL COMMENT '事件所属设备类型',
  `event_device_code` varchar(64) DEFAULT NULL COMMENT '事件所属设备编号',
  `event_warehouse_code` varchar(64) DEFAULT NULL COMMENT '事件所属仓库',
  `event_map_code` varchar(64) DEFAULT NULL COMMENT '事件所属地图',
  `command_id` varchar(64) DEFAULT NULL COMMENT '指令ID',
  `event_shelf_code` varchar(64) DEFAULT NULL COMMENT '事件载具号',
  `event_status` smallint DEFAULT NULL COMMENT '事件状态(10：未处理；20：处理中；30：处理成功；40：处理失败；50,失败待处理)',
  `event_process_by` varchar(32) DEFAULT NULL COMMENT '处理者',
  `event_process_times` int DEFAULT NULL COMMENT '事件重试次数',
  `event_content` longtext COMMENT '事件内容',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `event_failure_reason` text COMMENT '事件失败原因',
  `event_msg` text COMMENT '上报消息报文',
  PRIMARY KEY (`event_id`) USING BTREE,
  KEY `idx_event_info_st_lupd` (`event_status`,`last_updated_date`) USING BTREE,
  KEY `idx_last_update` (`last_updated_date`) USING BTREE,
  KEY `idx_t_ldm_core_event_info_n5` (`event_status`) USING BTREE,
  KEY `n_t_core_event_code` (`event_code`) USING BTREE,
  KEY `n_t_core_event_crt_date` (`creation_date`) USING BTREE,
  KEY `n_t_ldm_core_event_info_n1` (`event_code`,`command_id`) USING BTREE,
  KEY `n_t_ldm_core_event_info_n2` (`req_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='事件记录表';

-- ----------------------------
-- Table structure for t_ldm_core_msg_rcv
-- ----------------------------
CREATE TABLE `t_ldm_core_msg_rcv` (
  `msg_rcv_req_id` varchar(64) NOT NULL COMMENT '请求消息ID',
  `msg_rcv_req_type` varchar(32) DEFAULT NULL COMMENT '请求类型(任务开始、任务举升、走出储位、进入排队区、任务完成)',
  `req_msg` text COMMENT '接收消息体',
  `rcpt_status` varchar(2) DEFAULT NULL COMMENT '处理状态',
  `msg_type` varchar(64) DEFAULT NULL COMMENT '消息类型',
  `msg_from` varchar(32) DEFAULT NULL COMMENT '发送方IP',
  `sub_task_code` varchar(64) DEFAULT NULL COMMENT '子任务编号',
  `data` text COMMENT '自定义',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`msg_rcv_req_id`) USING BTREE,
  KEY `idx_msgrcv_crd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='指令接收记录表';

-- ----------------------------
-- Table structure for t_ldm_core_msg_send
-- ----------------------------
CREATE TABLE `t_ldm_core_msg_send` (
  `msg_send_req_id` varchar(64) NOT NULL COMMENT '请求编号',
  `msg_send_req_type` varchar(32) DEFAULT NULL COMMENT '请求类型',
  `send_msg` longtext COMMENT '发送报文',
  `response_msg` text COMMENT '返回失败消息',
  `deal_status` varchar(2) DEFAULT NULL COMMENT '状态（1:未处理;2:发送中;3:处理异常;4:处理异常不重发;5:取消完成;6:发送异常;0:处理成功）',
  `target_system` varchar(64) DEFAULT NULL COMMENT '消息接收系统',
  `task_code` varchar(64) DEFAULT NULL COMMENT '单号',
  `third_invoke_type` varchar(32) DEFAULT NULL COMMENT '调用方式',
  `url` text COMMENT '第三方URL地址',
  `method` text COMMENT '第三方方法名',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`msg_send_req_id`) USING BTREE,
  KEY `idx_msgsend_crd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='指令发送记录表';

-- ----------------------------
-- Table structure for t_ldm_core_release_agv_lock
-- ----------------------------
CREATE TABLE `t_ldm_core_release_agv_lock` (
  `agv_release_id` varchar(64) NOT NULL COMMENT 'AGV释放ID',
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  `command_id` varchar(64) DEFAULT NULL COMMENT '指令ID',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `release_status` int DEFAULT NULL COMMENT '设备解锁状态：0=待解锁；1=解锁成功；2=解锁失败',
  `release_times` bigint DEFAULT NULL COMMENT '释放次数',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`agv_release_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备锁定释放表';

-- ----------------------------
-- Table structure for t_ldm_core_task
-- ----------------------------
CREATE TABLE `t_ldm_core_task` (
  `task_id` varchar(64) NOT NULL COMMENT '配送任务ID',
  `req_code` varchar(64) NOT NULL COMMENT '请求编号',
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `warehouse_code` varchar(64) DEFAULT NULL COMMENT '逻辑仓库编码',
  `source_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `source_bill_no` varchar(64) DEFAULT NULL COMMENT '来源单据号',
  `source_line_id` varchar(64) DEFAULT NULL COMMENT '来源任务行ID',
  `source_creation_date` datetime DEFAULT NULL COMMENT '源创建时间',
  `source_remark` text COMMENT '备注',
  `task_type` varchar(32) DEFAULT NULL COMMENT '任务类型(约定，包括WMS发起，与MLM发起，设备发起)',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `shelf_type_code` varchar(32) DEFAULT NULL COMMENT '货架/载具类型编码（线边超市GTP拣选，须指定空车类型）',
  `lpn_list` text COMMENT '栈板或料箱LPN号，多个LPN用“，”隔开',
  `lpn_type` varchar(32) DEFAULT NULL COMMENT 'LPN类型，默认10=栈板',
  `side_code` varchar(10) DEFAULT NULL COMMENT 'AB面（只适用于多层货架模式）',
  `business_warehouse_code` varchar(64) DEFAULT NULL COMMENT '业务仓库代码',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `from_map_data_code` varchar(64) DEFAULT NULL COMMENT '源货位',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标货区代码',
  `to_map_data_code` varchar(64) DEFAULT NULL COMMENT '目标货位',
  `require_delivery_date` datetime DEFAULT NULL COMMENT '要求交付时间',
  `task_status` bigint DEFAULT NULL COMMENT '任务状态（10初始 20已拆分 30已下发 40启动 50任务完成 60关闭 90取消）',
  `priority` decimal(65,30) DEFAULT NULL COMMENT '优先级(根据急料标识、订单优先级、任务优先级、创建时间合并)',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `frequence` bigint DEFAULT NULL COMMENT '物料高低频:10-高高频;30-高频;50-低频.',
  `part_no` varchar(64) DEFAULT NULL COMMENT '物料编码',
  `lpn_qty` bigint DEFAULT NULL COMMENT 'LPN数量',
  `epa_flag` varchar(1) DEFAULT NULL COMMENT '默认N,静电区标识;Y:静电区EPA,N:非静电区NEPA',
  `plan_complete_date` datetime DEFAULT NULL COMMENT '任务预计完成时间',
  `cancel_by` varchar(32) DEFAULT NULL COMMENT '任务取消人',
  `cancel_date` datetime DEFAULT NULL COMMENT '任务取消时间',
  `cancel_reason_code` text COMMENT '任务取消原因代码',
  `urgent_flag` varchar(1) DEFAULT NULL COMMENT '紧急标识Y/N; 默认为N',
  `from_map_code` varchar(64) DEFAULT NULL COMMENT '源地图编号',
  `to_map_code` varchar(64) DEFAULT NULL COMMENT '目标地图编号',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `ldm_to_ai_status` smallint DEFAULT NULL COMMENT '指令推送LDM-AI状态（10初始/20待推送AI/30推送成功/40推送失败）',
  `ldm_to_ai_times` bigint DEFAULT NULL COMMENT '指令推送到AI的次数',
  `process_by` varchar(32) DEFAULT NULL COMMENT '处理服务器名称或IP',
  `map_data_type` varchar(64) DEFAULT NULL COMMENT '货位/地码类型',
  `cargo_weight` decimal(10,3) DEFAULT NULL COMMENT '货物重量',
  `cargo_height` decimal(10,3) DEFAULT NULL COMMENT '货物高度',
  `from_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '来源仓位',
  `to_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '目标仓位',
  `task_completed_time` datetime DEFAULT NULL COMMENT '任务完成时间',
  `multi_to_area_code` text COMMENT '多目标区域',
  `multi_to_map_data_code` text COMMENT '多目标货位,用半角逗号分隔',
  `trigger_by_source_name` varchar(32) DEFAULT NULL COMMENT '多目的区域任务触发方式,数字或者PRE_EVENT。为数字时，任务为多目的区域延时触发任务，同时也是延时触发的时间，单位为秒；为PRE_EVENT时，任务为多目的区域前置事件触发任务)',
  PRIMARY KEY (`task_id`) USING BTREE,
  KEY `idx_core_task_stat_ai_ait_pri` (`task_status`,`ldm_to_ai_status`,`ldm_to_ai_times`,`priority`) USING BTREE,
  KEY `idx_t_ldm_core_task_req` (`req_code`) USING BTREE,
  KEY `idx_tldm_core_task_lsd` (`last_updated_date`) USING BTREE,
  KEY `n_t_ldm_core_task_n1` (`shelf_code`) USING BTREE,
  KEY `n_t_ldm_core_task_n2` (`source_name`,`source_line_id`) USING BTREE,
  KEY `n_tldm_core_task_cd` (`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='任务单';

-- ----------------------------
-- Table structure for t_ldm_rcs_charger
-- ----------------------------
CREATE TABLE `t_ldm_rcs_charger` (
  `charger_id` int NOT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  `charger_status` int DEFAULT NULL,
  `full_charge_flag` int DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`charger_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_cmd_link_info
-- ----------------------------
CREATE TABLE `t_ldm_rcs_cmd_link_info` (
  `data_index` int NOT NULL,
  `data_valid` int DEFAULT NULL,
  `robot_index` int DEFAULT NULL,
  `command_id` varchar(64) DEFAULT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `start_pos_x` int DEFAULT NULL,
  `start_pos_y` int DEFAULT NULL,
  `link_command_id` varchar(64) DEFAULT NULL,
  `link_area` text,
  `link_timeout` int DEFAULT NULL,
  `already_wait_time` int DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`data_index`) USING BTREE,
  KEY `idx_t_ldm_rcs_link_id_n1` (`command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_link_valid_n1` (`data_valid`) USING BTREE,
  KEY `tl_uuid_inx` (`command_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_command
-- ----------------------------
CREATE TABLE `t_ldm_rcs_command` (
  `rcs_command_id` int NOT NULL AUTO_INCREMENT,
  `map_code` varchar(64) DEFAULT NULL,
  `command_id` varchar(64) DEFAULT NULL,
  `robot_index` int DEFAULT NULL,
  `robot_type` int DEFAULT NULL,
  `robot_lists` text,
  `command_type` int DEFAULT NULL,
  `ams_upload` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `tps_ip` varchar(64) DEFAULT NULL,
  `tps_port` int DEFAULT NULL,
  `command_status` int DEFAULT NULL,
  `cancel_id` int DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `start_date` varchar(32) DEFAULT NULL,
  `finish_date` varchar(32) DEFAULT NULL,
  `content` text,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  `follow_lift` int DEFAULT NULL,
  PRIMARY KEY (`rcs_command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_cmd_id_n1` (`command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_cmd_status_n1` (`command_status`) USING BTREE,
  KEY `t_task_status_inx` (`command_status`) USING BTREE,
  KEY `t_uuid_inx` (`command_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_command_backup1007
-- ----------------------------
CREATE TABLE `t_ldm_rcs_command_backup1007` (
  `rcs_command_id` int DEFAULT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `command_id` varchar(64) DEFAULT NULL,
  `robot_index` int DEFAULT NULL,
  `robot_type` int DEFAULT NULL,
  `robot_lists` text,
  `command_type` int DEFAULT NULL,
  `ams_upload` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `tps_ip` varchar(64) DEFAULT NULL,
  `tps_port` int DEFAULT NULL,
  `command_status` int DEFAULT NULL,
  `cancel_id` int DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `start_date` varchar(32) DEFAULT NULL,
  `finish_date` varchar(32) DEFAULT NULL,
  `content` text,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  `follow_lift` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_conf
-- ----------------------------
CREATE TABLE `t_ldm_rcs_conf` (
  `rcs_config_id` int NOT NULL,
  `config_name` varchar(64) DEFAULT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `config_value` varchar(64) DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rcs_config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_elc_map
-- ----------------------------
CREATE TABLE `t_ldm_rcs_elc_map` (
  `map_code` varchar(64) NOT NULL,
  `map_name` varchar(64) DEFAULT NULL,
  `warehouse_id` varchar(64) DEFAULT NULL,
  `map_type_code` int DEFAULT NULL,
  `row_count` int DEFAULT NULL,
  `col_count` int DEFAULT NULL,
  `width` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `ams_ip` varchar(64) DEFAULT NULL,
  `ams_port` int DEFAULT NULL,
  `content` longtext,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`map_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_map_data
-- ----------------------------
CREATE TABLE `t_ldm_rcs_map_data` (
  `map_data_code` int NOT NULL AUTO_INCREMENT,
  `map_code` varchar(64) DEFAULT NULL,
  `map_element_type` int DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  `map_data_status` int DEFAULT NULL,
  `content` longtext,
  `valid_flag` varchar(1) DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`map_data_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1903 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_path_stat
-- ----------------------------
CREATE TABLE `t_ldm_rcs_path_stat` (
  `map_code` varchar(64) DEFAULT NULL,
  `rcs_command_id` int NOT NULL,
  `sub_command_id` int NOT NULL,
  `path_key_points` longtext,
  `path_all_points` longtext,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rcs_command_id`,`sub_command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_path_stat_n1` (`rcs_command_id`,`sub_command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_path_stat_n2` (`map_code`,`creation_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_point_heat_stat
-- ----------------------------
CREATE TABLE `t_ldm_rcs_point_heat_stat` (
  `map_code` varchar(64) NOT NULL,
  `point` varchar(64) NOT NULL,
  `duration_type` int NOT NULL,
  `hit_count` int DEFAULT NULL,
  `stat_begin_time` varchar(32) DEFAULT NULL,
  `stat_end_time` varchar(32) DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`map_code`,`point`,`duration_type`) USING BTREE,
  KEY `idx_t_ldm_rcs_point_heat_stat_n1` (`map_code`,`point`,`duration_type`) USING BTREE,
  KEY `idx_t_ldm_rcs_point_heat_stat_n2` (`map_code`,`duration_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_robot
-- ----------------------------
CREATE TABLE `t_ldm_rcs_robot` (
  `robot_code` int NOT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `robot_name` varchar(64) DEFAULT NULL,
  `remove_flag` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `robot_type_code` varchar(64) DEFAULT NULL,
  `stay` int DEFAULT NULL,
  `navigate_type` int DEFAULT NULL,
  `download_addr` text,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`robot_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_shelf
-- ----------------------------
CREATE TABLE `t_ldm_rcs_shelf` (
  `shelf_code` varchar(64) NOT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `robot_index` int DEFAULT NULL,
  `sub_task_code` int DEFAULT NULL,
  `shelf_status` int DEFAULT NULL,
  `shelf_type` int DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`shelf_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_sp_point
-- ----------------------------
CREATE TABLE `t_ldm_rcs_sp_point` (
  `sp_point_code` int NOT NULL,
  `sp_type` int DEFAULT NULL,
  `map_code` varchar(64) DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  `point_int1` int DEFAULT NULL,
  `point_int2` int DEFAULT NULL,
  `point_str1` varchar(64) DEFAULT NULL,
  `point_str2` text,
  `valid_flag` varchar(1) DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`sp_point_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_rcs_sub_command
-- ----------------------------
CREATE TABLE `t_ldm_rcs_sub_command` (
  `command_id` varchar(64) NOT NULL,
  `sub_command_id` int NOT NULL,
  `action` int DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  `robot_dir` int DEFAULT NULL,
  `mark` int DEFAULT NULL,
  `sub_content` longtext,
  `sub_status` int DEFAULT NULL,
  `creation_date` varchar(32) DEFAULT NULL,
  `finish_date` varchar(32) DEFAULT NULL,
  `remark` text,
  `created_by` varchar(32) DEFAULT NULL,
  `created_by_name` varchar(32) DEFAULT NULL,
  `last_updated_by` varchar(32) DEFAULT NULL,
  `last_updated_by_name` varchar(32) DEFAULT NULL,
  `last_updated_date` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`command_id`,`sub_command_id`) USING BTREE,
  KEY `idx_t_ldm_rcs_sub_id_n1` (`command_id`) USING BTREE,
  KEY `tm_uuid_inx` (`command_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for t_ldm_sams_agv_lock
-- ----------------------------
CREATE TABLE `t_ldm_sams_agv_lock` (
  `agv_lock_id` varchar(64) NOT NULL COMMENT 'AGV锁ID',
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  `command_id` varchar(64) DEFAULT NULL COMMENT '指令ID',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `lock_status` int DEFAULT NULL COMMENT '设备锁状态：0=锁定；1=释放',
  `lpn_code` text COMMENT '搬运对象（载具、栈板）',
  `version_id` text COMMENT '版本号',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `map_code` varchar(64) DEFAULT NULL COMMENT ' 地图编号',
  PRIMARY KEY (`agv_lock_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='设备占用表';

-- ----------------------------
-- Table structure for t_ldm_sams_charge_config
-- ----------------------------
CREATE TABLE `t_ldm_sams_charge_config` (
  `config_id` varchar(64) NOT NULL COMMENT '充电配置ID',
  `map_code` varchar(64) DEFAULT NULL COMMENT ' 地图编号',
  `low_power_charge_flag` varchar(1) DEFAULT NULL COMMENT '低电量充电配置（Y=开启，N=关闭，默认为N）',
  `idle_charge_flag` varchar(1) DEFAULT NULL COMMENT '闲时充电配置（Y=开启，N=关闭，默认为N）',
  `low_power_threshold` int DEFAULT NULL COMMENT '低电量阈值（10~90）',
  `idle_time_threshold` int DEFAULT NULL COMMENT '空闲时间阈值（单位：分钟）',
  `charge_time` int DEFAULT NULL COMMENT '充电时间（单位：分钟）',
  `break_charge_threshold` int DEFAULT NULL COMMENT '可打断的充电阈值（10~90）',
  `valid_flag` varchar(1) DEFAULT NULL COMMENT '是否有效（Y=有效，N= 无效）',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `can_interrupt` varchar(1) DEFAULT NULL COMMENT '是否可打断（Y/N）',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE KEY `unq_charge_cfg_map_code` (`map_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='充电配置表';

-- ----------------------------
-- Table structure for t_ldm_sams_command
-- ----------------------------
CREATE TABLE `t_ldm_sams_command` (
  `command_id` varchar(64) NOT NULL COMMENT '指令ID',
  `choose_agv_process_status` smallint DEFAULT NULL COMMENT '选车处理状态（10待选车/20处理中/30选车成功/40下发成功/50下发失败待处理/60下发失败80/指令完成/90取消）',
  `command_no` smallint DEFAULT NULL COMMENT '指令序号（同SPLIT_H_ID下指令的排列序号）',
  `command_type` varchar(32) DEFAULT NULL COMMENT '指令类型（MOVE行走/DELIVERY搬运/RECHARGE充电/ROTATE旋转）',
  `business_type` varchar(32) DEFAULT NULL COMMENT '业务类型',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `device_type_code` varchar(64) DEFAULT NULL COMMENT '设备类型编号',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `from_area_building_floor` varchar(64) DEFAULT NULL COMMENT '来源区域楼层',
  `from_map_code` varchar(64) DEFAULT NULL COMMENT '源地图编号',
  `from_map_data_code` varchar(64) DEFAULT NULL COMMENT '源货位',
  `start_x` decimal(10,3) DEFAULT NULL COMMENT '起点X',
  `start_y` decimal(10,3) DEFAULT NULL COMMENT '起点Y',
  `end_x` decimal(10,3) DEFAULT NULL COMMENT '终点X',
  `end_y` decimal(10,3) DEFAULT NULL COMMENT '终点Y',
  `to_area_code` varchar(64) DEFAULT NULL COMMENT '目标货区代码',
  `to_map_code` varchar(64) DEFAULT NULL COMMENT '目标地图编号',
  `to_map_data_code` varchar(64) DEFAULT NULL COMMENT '目标货位',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `to_area_building_floor` varchar(64) DEFAULT NULL COMMENT '目标区域楼层',
  `device_list` longtext COMMENT '设备能力列表',
  `from_area_id` varchar(64) DEFAULT NULL COMMENT '源货区ID',
  `to_area_id` varchar(64) DEFAULT NULL COMMENT '目标货区ID',
  `priority` decimal(65,30) DEFAULT NULL COMMENT '优先级',
  `process_by` varchar(64) DEFAULT NULL COMMENT '处理者',
  `lock_by` varchar(128) DEFAULT NULL COMMENT '锁信息',
  `send_times` int DEFAULT NULL COMMENT '下发次数',
  `same_agv_grp_type` int DEFAULT NULL COMMENT '同组类型（0、无同组；1：指令同组；2：任务同组）',
  `same_agv_grp_last_flag` varchar(2) DEFAULT NULL COMMENT '同组最后一条指令标识',
  `agv_lift_start_flag` varchar(2) DEFAULT NULL COMMENT '指令开始后AGV举升标识（Y举升/N放下/B保持）',
  `agv_lift_end_flag` varchar(2) DEFAULT NULL COMMENT '指令完成后AGV举升标识（Y举升/N放下）',
  `task_id` varchar(64) DEFAULT NULL COMMENT '任务ID',
  `ability_group_l_id` varchar(64) DEFAULT NULL COMMENT '设备能力组行ID',
  PRIMARY KEY (`command_id`) USING BTREE,
  KEY `idx_sams_cmd_lid_status` (`ability_group_l_id`,`choose_agv_process_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='子任务单';

-- ----------------------------
-- Table structure for ti_ldm_core_task
-- ----------------------------
CREATE TABLE `ti_ldm_core_task` (
  `task_id` varchar(64) NOT NULL COMMENT '任务ID',
  `req_code` varchar(64) NOT NULL COMMENT '请求编号',
  `site_id` varchar(64) DEFAULT NULL COMMENT '工厂ID',
  `source_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `source_bill_no` varchar(64) DEFAULT NULL COMMENT '来源单据号',
  `source_line_id` varchar(64) DEFAULT NULL COMMENT '来源任务行ID',
  `source_creation_date` datetime DEFAULT NULL COMMENT '源创建时间',
  `source_remark` text COMMENT '来源备注',
  `task_type` varchar(32) DEFAULT NULL COMMENT '任务类型(约定，包括WMS发起，与MLM发起，设备发起)',
  `shelf_code` varchar(64) DEFAULT NULL COMMENT '货架/载具编号',
  `shelf_type_code` varchar(64) DEFAULT NULL COMMENT '货架/载具类型编码（线边超市GTP拣选，须指定空车类型）',
  `lpn_list` text COMMENT '栈板或料箱LPN号，多个LPN用“，”隔开',
  `lpn_type` varchar(32) DEFAULT NULL COMMENT 'LPN类型，默认10=栈板',
  `side_code` varchar(10) DEFAULT NULL COMMENT 'AB面（只适用于多层货架模式）',
  `business_warehouse_code` varchar(64) DEFAULT NULL COMMENT '业务仓库代码',
  `warehouse_code` varchar(64) DEFAULT NULL COMMENT '逻辑仓库编码',
  `from_map_code` varchar(64) DEFAULT NULL COMMENT '源地图编码',
  `from_area_code` varchar(64) DEFAULT NULL COMMENT '源货区代码',
  `from_map_data_code` varchar(64) DEFAULT NULL COMMENT '源位置',
  `to_map_code` varchar(64) DEFAULT NULL COMMENT '目标地图编码',
  `to_area_code` text COMMENT '目标货区代码，多个用“，”隔开',
  `to_map_data_code` varchar(64) DEFAULT NULL COMMENT '目标货位',
  `require_delivery_date` datetime DEFAULT NULL COMMENT '要求交付时间',
  `process_by` varchar(32) DEFAULT NULL COMMENT '处理服务器名称或IP',
  `process_times` bigint DEFAULT NULL COMMENT '处理次数（默认为0）',
  `process_status` bigint DEFAULT NULL COMMENT '处理状态（10初始 20处理中 30处理成功 40处理失败 50失败待处理 900取消）',
  `process_error_message` text COMMENT '处理失败信息',
  `order_priority` smallint DEFAULT NULL COMMENT '订单类型优先级，业务优先级',
  `task_priority` smallint DEFAULT NULL COMMENT '任务优先级（按任务类型）',
  `device_code` varchar(64) DEFAULT NULL COMMENT '设备编号',
  `frequence` bigint DEFAULT NULL COMMENT '物料高低频:10-高高频;30-高频;50-低频.',
  `part_no` varchar(64) DEFAULT NULL COMMENT '物料编码',
  `lpn_qty` bigint DEFAULT NULL COMMENT 'LPN数量',
  `epa_flag` varchar(1) DEFAULT NULL COMMENT '默认N,静电区标识;Y:静电区EPA,N:非静电区NEPA',
  `urgent_flag` varchar(1) DEFAULT NULL COMMENT '紧急标识Y/N;默认N',
  `remark` text COMMENT '备注',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `created_by_name` varchar(32) DEFAULT NULL COMMENT '创建人姓名',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated_by` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `last_updated_by_name` varchar(32) DEFAULT NULL COMMENT '最后更新人姓名',
  `last_updated_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  `map_data_type` varchar(64) DEFAULT NULL COMMENT '货位/地码类型',
  `cargo_weight` decimal(10,3) DEFAULT NULL COMMENT '货物重量',
  `cargo_height` decimal(10,3) DEFAULT NULL COMMENT '货物高度',
  `from_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '来源仓位',
  `to_stg_bin_code` varchar(64) DEFAULT NULL COMMENT '目标仓位',
  `multi_to_area_code` text COMMENT '多目标区域',
  `multi_to_map_data_code` text COMMENT '多目标货位,用半角逗号分隔',
  `trigger_by_source_name` varchar(32) DEFAULT NULL COMMENT '多目的区域任务触发方式,数字或者PRE_EVENT。为数字时，任务为多目的区域延时触发任务，同时也是延时触发的时间，单位为秒；为PRE_EVENT时，任务为多目的区域前置事件触发任务)',
  PRIMARY KEY (`task_id`) USING BTREE,
  UNIQUE KEY `unq_ti_ldm_core_task_u1` (`source_line_id`,`source_name`) USING BTREE,
  KEY `idx_ti_ldm_core_task_req` (`req_code`) USING BTREE,
  KEY `idx_ti_ldm_core_task_stat` (`process_status`) USING BTREE,
  KEY `idx_tildm_core_task_lsd` (`last_updated_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='任务单接口表，保留3天，定时迁移到HIS表(可迁移的状态：30处理成功 40处理失败 900取消)';

SET FOREIGN_KEY_CHECKS = 1;
