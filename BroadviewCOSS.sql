/*
PostgreSQL Backup
Database: BroadviewCOSS/public
Backup Time: 2018-06-15 16:35:59
*/

DROP TABLE IF EXISTS "public"."Category";
DROP TABLE IF EXISTS "public"."Mainframe";
DROP TABLE IF EXISTS "public"."MenuRole";
DROP TABLE IF EXISTS "public"."Menu";
DROP TABLE IF EXISTS "public"."OperationLog";
DROP TABLE IF EXISTS "public"."Permission";
DROP TABLE IF EXISTS "public"."RolePermission";
DROP TABLE IF EXISTS "public"."Role";
DROP TABLE IF EXISTS "public"."TaskCategory";
DROP TABLE IF EXISTS "public"."TaskMainframe";
DROP TABLE IF EXISTS "public"."TaskRun";
DROP TABLE IF EXISTS "public"."Task";
DROP TABLE IF EXISTS "public"."UserRole";
DROP TABLE IF EXISTS "public"."User";
DROP TABLE IF EXISTS "public"."auth_group";
DROP TABLE IF EXISTS "public"."auth_group_permissions";
DROP TABLE IF EXISTS "public"."auth_permission";
DROP TABLE IF EXISTS "public"."auth_user";
DROP TABLE IF EXISTS "public"."auth_user_groups";
DROP TABLE IF EXISTS "public"."auth_user_user_permissions";
DROP TABLE IF EXISTS "public"."celery_taskmeta";
DROP TABLE IF EXISTS "public"."celery_tasksetmeta";
DROP TABLE IF EXISTS "public"."django_admin_log";
DROP TABLE IF EXISTS "public"."django_content_type";
DROP TABLE IF EXISTS "public"."django_migrations";
DROP TABLE IF EXISTS "public"."django_session";
DROP TABLE IF EXISTS "public"."djcelery_crontabschedule";
DROP TABLE IF EXISTS "public"."djcelery_intervalschedule";
DROP TABLE IF EXISTS "public"."djcelery_periodictask";
DROP TABLE IF EXISTS "public"."djcelery_periodictasks";
DROP TABLE IF EXISTS "public"."djcelery_taskstate";
DROP TABLE IF EXISTS "public"."djcelery_workerstate";
CREATE TABLE "public"."Category" (
  "id" int4 NOT NULL DEFAULT nextval('"Category_id_seq"'::regclass),
  "name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."Category" OWNER TO "postgres";
CREATE TABLE "public"."Mainframe" (
  "id" int4 NOT NULL DEFAULT nextval('"Mainframe_id_seq"'::regclass),
  "ip" inet NOT NULL DEFAULT NULL,
  "hostname" varchar(30) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "status" int4 NOT NULL DEFAULT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "category" int4 NOT NULL DEFAULT NULL,
  "type" varchar(30) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."Mainframe" OWNER TO "postgres";
CREATE TABLE "public"."MenuRole" (
  "id" int4 NOT NULL DEFAULT nextval('"MenuRole_id_seq"'::regclass),
  "menu" int4 NOT NULL DEFAULT NULL,
  "role" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."MenuRole" OWNER TO "postgres";
CREATE TABLE "public"."Menu" (
  "id" int4 NOT NULL DEFAULT nextval('"Menu_id_seq"'::regclass),
  "name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "parent" int4 NOT NULL DEFAULT NULL,
  "sub" int4 NOT NULL DEFAULT NULL,
  "url" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "icon" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "index" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."Menu" OWNER TO "postgres";
CREATE TABLE "public"."OperationLog" (
  "id" int4 NOT NULL DEFAULT nextval('"OperationLog_id_seq"'::regclass),
  "content" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "time" timestamptz(6) NOT NULL DEFAULT NULL,
  "user" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."OperationLog" OWNER TO "postgres";
CREATE TABLE "public"."Permission" (
  "id" int4 NOT NULL DEFAULT nextval('"Permission_id_seq"'::regclass),
  "view" bool NOT NULL DEFAULT NULL,
  "update" bool NOT NULL DEFAULT NULL,
  "delete" bool NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."Permission" OWNER TO "postgres";
CREATE TABLE "public"."RolePermission" (
  "id" int4 NOT NULL DEFAULT nextval('"RolePermission_id_seq"'::regclass),
  "permission" int4 NOT NULL DEFAULT NULL,
  "role" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."RolePermission" OWNER TO "postgres";
CREATE TABLE "public"."Role" (
  "id" int4 NOT NULL DEFAULT nextval('"Role_id_seq"'::regclass),
  "name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."Role" OWNER TO "postgres";
CREATE TABLE "public"."TaskCategory" (
  "id" int4 NOT NULL DEFAULT nextval('"TaskCategory_id_seq"'::regclass),
  "category" int4 NOT NULL DEFAULT NULL,
  "task" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."TaskCategory" OWNER TO "postgres";
CREATE TABLE "public"."TaskMainframe" (
  "id" int4 NOT NULL DEFAULT nextval('"TaskMainframe_id_seq"'::regclass),
  "mainframe" int4 NOT NULL DEFAULT NULL,
  "task" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."TaskMainframe" OWNER TO "postgres";
CREATE TABLE "public"."TaskRun" (
  "id" int4 NOT NULL DEFAULT nextval('"TaskRun_id_seq"'::regclass),
  "start_time" timestamptz(6) NOT NULL DEFAULT NULL,
  "end_time" timestamptz(6) DEFAULT NULL,
  "status" int4 NOT NULL DEFAULT NULL,
  "result" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "task" int4 NOT NULL DEFAULT NULL,
  "user" int4 DEFAULT NULL
)
;ALTER TABLE "public"."TaskRun" OWNER TO "postgres";
CREATE TABLE "public"."Task" (
  "id" int4 NOT NULL DEFAULT nextval('"Task_id_seq"'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "task" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "create_date" timestamptz(6) NOT NULL DEFAULT NULL,
  "last_update" timestamptz(6) NOT NULL DEFAULT NULL,
  "user" int4 DEFAULT NULL
)
;ALTER TABLE "public"."Task" OWNER TO "postgres";
CREATE TABLE "public"."UserRole" (
  "id" int4 NOT NULL DEFAULT nextval('"UserRole_id_seq"'::regclass),
  "role" int4 NOT NULL DEFAULT NULL,
  "user" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."UserRole" OWNER TO "postgres";
CREATE TABLE "public"."User" (
  "id" int4 NOT NULL DEFAULT nextval('"User_id_seq"'::regclass),
  "username" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "password" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "last_login" timestamptz(6) DEFAULT NULL,
  "is_active" bool NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."User" OWNER TO "postgres";
CREATE TABLE "public"."auth_group" (
  "id" int4 NOT NULL DEFAULT nextval('auth_group_id_seq'::regclass),
  "name" varchar(80) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_group" OWNER TO "postgres";
CREATE TABLE "public"."auth_group_permissions" (
  "id" int4 NOT NULL DEFAULT nextval('auth_group_permissions_id_seq'::regclass),
  "group_id" int4 NOT NULL DEFAULT NULL,
  "permission_id" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_group_permissions" OWNER TO "postgres";
CREATE TABLE "public"."auth_permission" (
  "id" int4 NOT NULL DEFAULT nextval('auth_permission_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "content_type_id" int4 NOT NULL DEFAULT NULL,
  "codename" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_permission" OWNER TO "postgres";
CREATE TABLE "public"."auth_user" (
  "id" int4 NOT NULL DEFAULT nextval('auth_user_id_seq'::regclass),
  "password" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "last_login" timestamptz(6) DEFAULT NULL,
  "is_superuser" bool NOT NULL DEFAULT NULL,
  "username" varchar(150) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "first_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "last_name" varchar(150) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "email" varchar(254) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "is_staff" bool NOT NULL DEFAULT NULL,
  "is_active" bool NOT NULL DEFAULT NULL,
  "date_joined" timestamptz(6) NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_user" OWNER TO "postgres";
CREATE TABLE "public"."auth_user_groups" (
  "id" int4 NOT NULL DEFAULT nextval('auth_user_groups_id_seq'::regclass),
  "user_id" int4 NOT NULL DEFAULT NULL,
  "group_id" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_user_groups" OWNER TO "postgres";
CREATE TABLE "public"."auth_user_user_permissions" (
  "id" int4 NOT NULL DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass),
  "user_id" int4 NOT NULL DEFAULT NULL,
  "permission_id" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."auth_user_user_permissions" OWNER TO "postgres";
CREATE TABLE "public"."celery_taskmeta" (
  "id" int4 NOT NULL DEFAULT nextval('celery_taskmeta_id_seq'::regclass),
  "task_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "status" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "result" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "date_done" timestamptz(6) NOT NULL DEFAULT NULL,
  "traceback" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "hidden" bool NOT NULL DEFAULT NULL,
  "meta" text COLLATE "pg_catalog"."default" DEFAULT NULL
)
;ALTER TABLE "public"."celery_taskmeta" OWNER TO "postgres";
CREATE TABLE "public"."celery_tasksetmeta" (
  "id" int4 NOT NULL DEFAULT nextval('celery_tasksetmeta_id_seq'::regclass),
  "taskset_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "result" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "date_done" timestamptz(6) NOT NULL DEFAULT NULL,
  "hidden" bool NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."celery_tasksetmeta" OWNER TO "postgres";
CREATE TABLE "public"."django_admin_log" (
  "id" int4 NOT NULL DEFAULT nextval('django_admin_log_id_seq'::regclass),
  "action_time" timestamptz(6) NOT NULL DEFAULT NULL,
  "object_id" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "object_repr" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "action_flag" int2 NOT NULL DEFAULT NULL,
  "change_message" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "content_type_id" int4 DEFAULT NULL,
  "user_id" int4 NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."django_admin_log" OWNER TO "postgres";
CREATE TABLE "public"."django_content_type" (
  "id" int4 NOT NULL DEFAULT nextval('django_content_type_id_seq'::regclass),
  "app_label" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "model" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."django_content_type" OWNER TO "postgres";
CREATE TABLE "public"."django_migrations" (
  "id" int4 NOT NULL DEFAULT nextval('django_migrations_id_seq'::regclass),
  "app" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "applied" timestamptz(6) NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."django_migrations" OWNER TO "postgres";
CREATE TABLE "public"."django_session" (
  "session_key" varchar(40) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "session_data" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "expire_date" timestamptz(6) NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."django_session" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_crontabschedule" (
  "id" int4 NOT NULL DEFAULT nextval('djcelery_crontabschedule_id_seq'::regclass),
  "minute" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "hour" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "day_of_week" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "day_of_month" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "month_of_year" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_crontabschedule" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_intervalschedule" (
  "id" int4 NOT NULL DEFAULT nextval('djcelery_intervalschedule_id_seq'::regclass),
  "every" int4 NOT NULL DEFAULT NULL,
  "period" varchar(24) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_intervalschedule" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_periodictask" (
  "id" int4 NOT NULL DEFAULT nextval('djcelery_periodictask_id_seq'::regclass),
  "name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "task" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "args" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "kwargs" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "queue" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL,
  "exchange" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL,
  "routing_key" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL,
  "expires" timestamptz(6) DEFAULT NULL,
  "enabled" bool NOT NULL DEFAULT NULL,
  "last_run_at" timestamptz(6) DEFAULT NULL,
  "total_run_count" int4 NOT NULL DEFAULT NULL,
  "date_changed" timestamptz(6) NOT NULL DEFAULT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "crontab_id" int4 DEFAULT NULL,
  "interval_id" int4 DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_periodictask" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_periodictasks" (
  "ident" int2 NOT NULL DEFAULT NULL,
  "last_update" timestamptz(6) NOT NULL DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_periodictasks" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_taskstate" (
  "id" int4 NOT NULL DEFAULT nextval('djcelery_taskstate_id_seq'::regclass),
  "state" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "task_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL,
  "tstamp" timestamptz(6) NOT NULL DEFAULT NULL,
  "args" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "kwargs" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "eta" timestamptz(6) DEFAULT NULL,
  "expires" timestamptz(6) DEFAULT NULL,
  "result" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "traceback" text COLLATE "pg_catalog"."default" DEFAULT NULL,
  "runtime" float8 DEFAULT NULL,
  "retries" int4 NOT NULL DEFAULT NULL,
  "hidden" bool NOT NULL DEFAULT NULL,
  "worker_id" int4 DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_taskstate" OWNER TO "postgres";
CREATE TABLE "public"."djcelery_workerstate" (
  "id" int4 NOT NULL DEFAULT nextval('djcelery_workerstate_id_seq'::regclass),
  "hostname" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT NULL,
  "last_heartbeat" timestamptz(6) DEFAULT NULL
)
;ALTER TABLE "public"."djcelery_workerstate" OWNER TO "postgres";
BEGIN;
LOCK TABLE "public"."Category" IN SHARE MODE;
DELETE FROM "public"."Category";
INSERT INTO "public"."Category" ("id","name","description") VALUES (0, '默认', '默认分类');
COMMIT;
BEGIN;
LOCK TABLE "public"."Mainframe" IN SHARE MODE;
DELETE FROM "public"."Mainframe";
INSERT INTO "public"."Mainframe" ("id","ip","hostname","status","description","category","type") VALUES (4, '19.19.19.52', 'Windows测试机', 0, 'Windows测试机', 0, 'Windows'),(5, '192.168.192.104', 'Linux测试机', 0, 'Linux测试机', 0, 'Linux');
COMMIT;
BEGIN;
LOCK TABLE "public"."MenuRole" IN SHARE MODE;
DELETE FROM "public"."MenuRole";
INSERT INTO "public"."MenuRole" ("id","menu","role") VALUES (1, 1, 1),(2, 2, 1),(3, 3, 1),(4, 4, 1),(5, 5, 1),(6, 6, 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."Menu" IN SHARE MODE;
DELETE FROM "public"."Menu";
INSERT INTO "public"."Menu" ("id","name","parent","sub","url","icon","index") VALUES (1, '首页', 0, 0, 'index', 'fa-dashboard', 0),(2, '主机管理', 0, 0, 'mainframe', 'fa-laptop', 1),(4, '分类管理', 0, 0, 'category', 'fa-sitemap', 3),(5, '角色管理', 0, 0, 'role', 'fa-user', 4),(6, '用户管理', 0, 0, 'user', 'fa-users', 5),(3, '作业管理', 0, 0, 'task', 'fa-tasks', 2);
COMMIT;
BEGIN;
LOCK TABLE "public"."OperationLog" IN SHARE MODE;
DELETE FROM "public"."OperationLog";
COMMIT;
BEGIN;
LOCK TABLE "public"."Permission" IN SHARE MODE;
DELETE FROM "public"."Permission";
INSERT INTO "public"."Permission" ("id","view","update","delete") VALUES (1, 't', 't', 't'),(2, 't', 't', 'f'),(3, 't', 'f', 'f');
COMMIT;
BEGIN;
LOCK TABLE "public"."RolePermission" IN SHARE MODE;
DELETE FROM "public"."RolePermission";
INSERT INTO "public"."RolePermission" ("id","permission","role") VALUES (1, 1, 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."Role" IN SHARE MODE;
DELETE FROM "public"."Role";
INSERT INTO "public"."Role" ("id","name","description") VALUES (1, '管理员', '拥有全部权限');
COMMIT;
BEGIN;
LOCK TABLE "public"."TaskCategory" IN SHARE MODE;
DELETE FROM "public"."TaskCategory";
COMMIT;
BEGIN;
LOCK TABLE "public"."TaskMainframe" IN SHARE MODE;
DELETE FROM "public"."TaskMainframe";
INSERT INTO "public"."TaskMainframe" ("id","mainframe","task") VALUES (6, 5, 3),(7, 4, 4);
COMMIT;
BEGIN;
LOCK TABLE "public"."TaskRun" IN SHARE MODE;
DELETE FROM "public"."TaskRun";
INSERT INTO "public"."TaskRun" ("id","start_time","end_time","status","result","task","user") VALUES (10, '2018-06-15 16:15:00+08', '2018-06-15 16:16:05.881333+08', 0, '任务在 192.168.192.104 上运行成功：,/root/python/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin,root     pts/1        2018-06-14 17:32 (192.168.192.1)', 3, 1),(11, '2018-06-15 16:15:00+08', '2018-06-15 16:16:09.256684+08', 0, '任务在 19.19.19.52 上运行成功：,正在 Ping www.a.shifen.com [14.215.177.39] 具有 32 字节的数据:,来自 14.215.177.39 的回复: 字节=32 时间=9ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=8ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=8ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=8ms TTL=54,14.215.177.39 的 Ping 统计信息:,    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，,往返行程的估计时间(以毫秒为单位):,    最短 = 8ms，最长 = 9ms，平均 = 8ms,Windows IP 配置,以太网适配器 本地连接:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::3dce:fa3a:899d:1d6a%13,   IPv4 地址 . . . . . . . . . . . . : 19.19.19.52,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : 19.19.19.1,以太网适配器 以太网:,   媒体状态  . . . . . . . . . . . . : 媒体已断开连接,   连接特定的 DNS 后缀 . . . . . . . : ,以太网适配器 VMware Network Adapter VMnet1:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::f19f:373f:ef9f:a878%18,   IPv4 地址 . . . . . . . . . . . . : 192.168.227.1,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : ,以太网适配器 VMware Network Adapter VMnet8:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::786a:cec3:af7a:c5d4%4,   IPv4 地址 . . . . . . . . . . . . : 192.168.192.1,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : 192.168.192.2', 4, 1),(12, '2018-06-15 16:17:00+08', '2018-06-15 16:18:09.007671+08', 0, '任务在 19.19.19.52 上运行成功：,命令：ping www.baidu.com&ipconfig,正在 Ping www.a.shifen.com [14.215.177.39] 具有 32 字节的数据:,来自 14.215.177.39 的回复: 字节=32 时间=12ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=9ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=8ms TTL=54,来自 14.215.177.39 的回复: 字节=32 时间=8ms TTL=54,14.215.177.39 的 Ping 统计信息:,    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，,往返行程的估计时间(以毫秒为单位):,    最短 = 8ms，最长 = 12ms，平均 = 9ms,Windows IP 配置,以太网适配器 本地连接:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::3dce:fa3a:899d:1d6a%13,   IPv4 地址 . . . . . . . . . . . . : 19.19.19.52,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : 19.19.19.1,以太网适配器 以太网:,   媒体状态  . . . . . . . . . . . . : 媒体已断开连接,   连接特定的 DNS 后缀 . . . . . . . : ,以太网适配器 VMware Network Adapter VMnet1:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::f19f:373f:ef9f:a878%18,   IPv4 地址 . . . . . . . . . . . . : 192.168.227.1,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : ,以太网适配器 VMware Network Adapter VMnet8:,   连接特定的 DNS 后缀 . . . . . . . : ,   本地链接 IPv6 地址. . . . . . . . : fe80::786a:cec3:af7a:c5d4%4,   IPv4 地址 . . . . . . . . . . . . : 192.168.192.1,   子网掩码  . . . . . . . . . . . . : 255.255.255.0,   默认网关. . . . . . . . . . . . . : 192.168.192.2', 4, 1),(8, '2018-06-15 16:11:00+08', '2018-06-15 16:11:28.564548+08', 0, '任务在 192.168.192.104 上运行成功：,/root/python/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin,root     pts/1        2018-06-14 17:32 (192.168.192.1)', 3, 1),(9, '2018-06-15 16:11:00+08', '2018-06-15 16:11:59.498302+08', 0, '任务在 19.19.19.52 上运行成功：,正在 Ping www.a.shifen.com [14.215.177.38] 具有 32 字节的数据:,来自 14.215.177.38 的回复: 字节=32 时间=7ms TTL=54,来自 14.215.177.38 的回复: 字节=32 时间=7ms TTL=54,来自 14.215.177.38 的回复: 字节=32 时间=6ms TTL=54,来自 14.215.177.38 的回复: 字节=32 时间=6ms TTL=54,14.215.177.38 的 Ping 统计信息:,    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，,往返行程的估计时间(以毫秒为单位):,    最短 = 6ms，最长 = 7ms，平均 = 6ms', 4, 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."Task" IN SHARE MODE;
DELETE FROM "public"."Task";
INSERT INTO "public"."Task" ("id","name","description","task","create_date","last_update","user") VALUES (3, 'Linux命令测试', 'Linux命令测试', 'echo $PATH,who am i', '2018-06-15 16:06:05.546723+08', '2018-06-15 16:06:05.546723+08', 1),(4, 'Windows命令测试', 'Windows命令测试', 'ping www.baidu.com,ipconfig', '2018-06-15 16:06:52.936565+08', '2018-06-15 16:06:52.936565+08', 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."UserRole" IN SHARE MODE;
DELETE FROM "public"."UserRole";
INSERT INTO "public"."UserRole" ("id","role","user") VALUES (2, 1, 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."User" IN SHARE MODE;
DELETE FROM "public"."User";
INSERT INTO "public"."User" ("id","username","password","last_login","is_active") VALUES (1, 'yylhbb', 'yylhbb', '2018-06-15 14:56:39.127018+08', 't');
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_group" IN SHARE MODE;
DELETE FROM "public"."auth_group";
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_group_permissions" IN SHARE MODE;
DELETE FROM "public"."auth_group_permissions";
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_permission" IN SHARE MODE;
DELETE FROM "public"."auth_permission";
INSERT INTO "public"."auth_permission" ("id","name","content_type_id","codename") VALUES (1, 'Can add log entry', 1, 'add_logentry'),(2, 'Can change log entry', 1, 'change_logentry'),(3, 'Can delete log entry', 1, 'delete_logentry'),(4, 'Can add permission', 2, 'add_permission'),(5, 'Can change permission', 2, 'change_permission'),(6, 'Can delete permission', 2, 'delete_permission'),(7, 'Can add group', 3, 'add_group'),(8, 'Can change group', 3, 'change_group'),(9, 'Can delete group', 3, 'delete_group'),(10, 'Can add user', 4, 'add_user'),(11, 'Can change user', 4, 'change_user'),(12, 'Can delete user', 4, 'delete_user'),(13, 'Can add content type', 5, 'add_contenttype'),(14, 'Can change content type', 5, 'change_contenttype'),(15, 'Can delete content type', 5, 'delete_contenttype'),(16, 'Can add session', 6, 'add_session'),(17, 'Can change session', 6, 'change_session'),(18, 'Can delete session', 6, 'delete_session'),(19, 'Can add category', 7, 'add_category'),(20, 'Can change category', 7, 'change_category'),(21, 'Can delete category', 7, 'delete_category'),(22, 'Can add mainframe', 8, 'add_mainframe'),(23, 'Can change mainframe', 8, 'change_mainframe'),(24, 'Can delete mainframe', 8, 'delete_mainframe'),(25, 'Can add menu', 9, 'add_menu'),(26, 'Can change menu', 9, 'change_menu'),(27, 'Can delete menu', 9, 'delete_menu'),(28, 'Can add menu role', 10, 'add_menurole'),(29, 'Can change menu role', 10, 'change_menurole'),(30, 'Can delete menu role', 10, 'delete_menurole'),(31, 'Can add operation log', 11, 'add_operationlog'),(32, 'Can change operation log', 11, 'change_operationlog'),(33, 'Can delete operation log', 11, 'delete_operationlog'),(34, 'Can add permission', 12, 'add_permission'),(35, 'Can change permission', 12, 'change_permission'),(36, 'Can delete permission', 12, 'delete_permission'),(37, 'Can add role', 13, 'add_role'),(38, 'Can change role', 13, 'change_role'),(39, 'Can delete role', 13, 'delete_role'),(40, 'Can add role permission', 14, 'add_rolepermission'),(41, 'Can change role permission', 14, 'change_rolepermission'),(42, 'Can delete role permission', 14, 'delete_rolepermission'),(43, 'Can add task', 15, 'add_task'),(44, 'Can change task', 15, 'change_task'),(45, 'Can delete task', 15, 'delete_task'),(46, 'Can add task category', 16, 'add_taskcategory'),(47, 'Can change task category', 16, 'change_taskcategory'),(48, 'Can delete task category', 16, 'delete_taskcategory'),(49, 'Can add task mainframe', 17, 'add_taskmainframe'),(50, 'Can change task mainframe', 17, 'change_taskmainframe'),(51, 'Can delete task mainframe', 17, 'delete_taskmainframe'),(52, 'Can add task run', 18, 'add_taskrun'),(53, 'Can change task run', 18, 'change_taskrun'),(54, 'Can delete task run', 18, 'delete_taskrun'),(55, 'Can add user', 19, 'add_user'),(56, 'Can change user', 19, 'change_user'),(57, 'Can delete user', 19, 'delete_user'),(58, 'Can add user role', 20, 'add_userrole'),(59, 'Can change user role', 20, 'change_userrole'),(60, 'Can delete user role', 20, 'delete_userrole'),(61, 'Can add crontab', 21, 'add_crontabschedule'),(62, 'Can change crontab', 21, 'change_crontabschedule'),(63, 'Can delete crontab', 21, 'delete_crontabschedule'),(64, 'Can add interval', 22, 'add_intervalschedule'),(65, 'Can change interval', 22, 'change_intervalschedule'),(66, 'Can delete interval', 22, 'delete_intervalschedule'),(67, 'Can add periodic task', 23, 'add_periodictask'),(68, 'Can change periodic task', 23, 'change_periodictask'),(69, 'Can delete periodic task', 23, 'delete_periodictask'),(70, 'Can add periodic tasks', 24, 'add_periodictasks'),(71, 'Can change periodic tasks', 24, 'change_periodictasks'),(72, 'Can delete periodic tasks', 24, 'delete_periodictasks'),(73, 'Can add task state', 25, 'add_taskmeta'),(74, 'Can change task state', 25, 'change_taskmeta'),(75, 'Can delete task state', 25, 'delete_taskmeta'),(76, 'Can add saved group result', 26, 'add_tasksetmeta'),(77, 'Can change saved group result', 26, 'change_tasksetmeta'),(78, 'Can delete saved group result', 26, 'delete_tasksetmeta'),(79, 'Can add task', 27, 'add_taskstate'),(80, 'Can change task', 27, 'change_taskstate'),(81, 'Can delete task', 27, 'delete_taskstate'),(82, 'Can add worker', 28, 'add_workerstate'),(83, 'Can change worker', 28, 'change_workerstate'),(84, 'Can delete worker', 28, 'delete_workerstate');
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_user" IN SHARE MODE;
DELETE FROM "public"."auth_user";
INSERT INTO "public"."auth_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined") VALUES (1, 'pbkdf2_sha256$100000$mWLvIH3gPOhd$GfJ5T9Il6sEDdv8Qa6VlCI4y3ZOKVPjB87VXFJmr1j8=', '2018-06-15 09:08:40.441383+08', 't', 'yylhbb', '', '', 'yylhbb@gmail.com', 't', 't', '2018-06-12 14:39:33.329673+08');
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_user_groups" IN SHARE MODE;
DELETE FROM "public"."auth_user_groups";
COMMIT;
BEGIN;
LOCK TABLE "public"."auth_user_user_permissions" IN SHARE MODE;
DELETE FROM "public"."auth_user_user_permissions";
COMMIT;
BEGIN;
LOCK TABLE "public"."celery_taskmeta" IN SHARE MODE;
DELETE FROM "public"."celery_taskmeta";
INSERT INTO "public"."celery_taskmeta" ("id","task_id","status","result","date_done","traceback","hidden","meta") VALUES (1, 'dc401ecc-bafa-44aa-93d5-333a05e6606d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:38.867108+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(3, 'b917b58e-cd7e-405f-a06b-ff545684d30c', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:38.936071+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(47, '7756eef9-bb5a-4a91-be4a-17621ed67704', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:25.369155+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(57, 'c0865f0d-e89b-49ea-971e-bceee81ffd39', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:15.32071+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(4, '21fe9fa8-6a39-4e54-9fc0-4eeb07e3806b', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:41.784453+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(48, 'df0df4a9-a976-4b22-a51f-0ce566891725', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:30.361269+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(58, 'e3b6d0dd-6a7a-418f-b5bc-775830b58f43', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:20.320862+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(5, '9ae9c492-5111-405a-8b26-177773adb165', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:46.779668+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(49, 'fa80e469-2b13-4854-ad91-0ffdeb7e2945', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:35.369463+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(59, '53550712-873d-46e5-84b5-195714995dab', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:25.32117+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(6, 'da6b796c-dd32-4511-ba67-339b0eea1b34', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:51.722808+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(50, 'f205a87e-5862-4f12-b534-ef00d4e0f7c1', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:40.364682+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(60, '1eee5bb8-ef61-47d9-96ed-a9f7a8c8530a', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:30.32037+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(7, 'e5f10523-23b5-4426-98e1-f977dc0aa0a4', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:56.818931+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(51, '294f84c8-f640-4485-a593-59707aee27cb', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:45.37181+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(61, '0d881bdc-65e9-4538-b2df-e4b024f3c096', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:35.320483+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(8, '59ab7a4c-c706-4e83-b22f-b54248b80cd3', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:53:01.739158+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(62, 'cbaa642f-f577-45be-b325-35e25a3f0be1', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:40.365637+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(9, '39cb723c-c443-4693-8954-3ec7500fb06e', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.042368+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(10, 'df731f83-9c6f-44eb-af0c-6e59500c8cbb', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.054361+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(12, '9502626d-9dca-46de-8971-6c262e2abbc7', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.095338+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(63, '6d91128f-c1e2-4d8e-a220-7d0052d3c479', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:45.377756+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(11, '16fd4dc5-50a0-4350-a522-4ec0fee25070', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.076349+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(14, '4b53d2ae-8f79-4a93-a4d4-453a445e27ec', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.12632+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(23, '9abe4267-3bf8-4a6b-8b56-24cd1e3ac4cd', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:25.312072+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(64, 'af037c3c-4740-4884-b1b3-d3e515406ea3', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:50.321953+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(13, '59cd500e-ff36-4b91-8bdf-d3c57dd26c2e', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.11234+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(16, 'fefcdeb3-79ae-40af-b79a-5b2833e6faf3', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.154304+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(25, '672c2452-771c-4148-bc9f-d8733b94ab0d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:35.314137+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(65, 'cc4654b1-ad1f-4dc6-a6cb-d01f87538038', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:55.377091+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(15, 'de6e51d2-1cde-4cd0-b9aa-7dbebf5606d7', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.153305+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(24, 'fc9c7cc8-cafb-4569-99e6-790d5a6657d0', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:30.313989+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(34, '390cc587-7f6d-4b8c-af2f-0d4f5d56e14b', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:20.314945+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(66, '9653e172-1486-478d-96d6-c1cd52884ad6', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:59:00.322244+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(17, 'ff610887-e70c-466a-9b9a-e9eb5808b3ee', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.185285+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(26, 'bb042f00-23ba-44ce-9665-d10d85e7fb3a', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:40.31327+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(36, '6c6ea6f1-a8e0-431e-98ca-01f3d71faedb', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:30.316262+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(18, '8b06e9e1-ce88-4d2b-b31d-f6089bc68c46', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.198279+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(27, '60a556fe-e9cd-4689-b1bc-0b9acf6eaf52', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:45.314492+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(37, '881f83c4-6e60-4a73-9bd2-9e3750217b05', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:35.31544+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(19, '2f750336-d5de-4884-b615-f678b9c89b8a', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.243252+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(28, '0cf7c773-8d03-44aa-a543-6bc79024bbfb', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:50.313933+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(38, '54a43f04-5079-4ee7-9b88-a14aed970a15', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:40.316548+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(20, 'e1d9dc55-5567-4448-8252-9c7094e61b7d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.273253+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(29, '398c172d-043e-4d9a-8cc9-6258ab1035fe', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:55.315072+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(39, 'dcf421f5-5ab0-4319-92f4-9ea80fa1fce3', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:45.316756+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(21, 'd79585f2-31b4-4372-87d8-65950722208b', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.304234+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(30, '99f0d574-03bd-4018-ade4-59a2129c6677', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:00.315277+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(40, '3b35bd16-d558-457c-9c83-bf1b2ed0c422', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:50.315923+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(22, '6b9db87c-54ef-4e7a-a899-acab8ba4750d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:55:23.364184+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(31, '8995737b-8a66-4cb5-9883-adb72dc45929', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:05.31439+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(41, '960ab5f1-1fc5-4afd-9dac-8a1f57a02e8c', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:55.317146+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(32, 'afde091f-b08a-4059-844b-56c3ee60761d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:10.364482+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(42, '33b56bbc-4055-4e19-a55c-fa7b2cb429ba', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:00.316431+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(52, '45b3bf5d-366a-4f4f-a9b5-98614e28cd85', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:50.31901+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(33, '4b7c7271-d10e-49ec-bd21-db9152da9a32', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:15.363727+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(43, '83149f5c-c9bd-44ab-af11-db286bde0c59', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:05.316638+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(53, 'dbde765c-55f6-455c-b43e-5f0586d7b5dd', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:55.319131+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(35, '78f45669-3e18-4771-995e-5393049c669e', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:56:25.392041+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(45, '4ca1049a-8622-422e-bc8c-7165dd9f4231', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:15.31793+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(55, '18f8df1f-b50f-4d7f-9302-7433b241b61a', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:05.320466+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(44, '68e6f84d-32a6-43d8-b499-d0bb9c5295ab', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:10.357723+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(54, 'afbcbe2e-bb33-45fa-b0fa-5edbdf1008b0', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:00.319338+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(46, 'eea00996-b848-412a-b291-73170e70ce66', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:57:20.367023+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(56, 'a608d2d0-9ee0-4301-8280-20a7c4b0e03d', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:58:10.320601+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9'),(2, '99dad1ed-2a26-45fa-a4c9-e2451160a3f9', 'SUCCESS', 'gAJLAy4=', '2018-06-12 15:52:38.841124+08', NULL, 'f', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
COMMIT;
BEGIN;
LOCK TABLE "public"."celery_tasksetmeta" IN SHARE MODE;
DELETE FROM "public"."celery_tasksetmeta";
COMMIT;
BEGIN;
LOCK TABLE "public"."django_admin_log" IN SHARE MODE;
DELETE FROM "public"."django_admin_log";
INSERT INTO "public"."django_admin_log" ("id","action_time","object_id","object_repr","action_flag","change_message","content_type_id","user_id") VALUES (1, '2018-06-12 15:37:13.917939+08', '1', 'every 5 seconds', 1, '[{"added": {}}]', 22, 1),(2, '2018-06-12 15:39:03.3661+08', '2', 'Test: every 5 seconds', 1, '[{"added": {}}]', 23, 1),(3, '2018-06-12 15:39:24.222175+08', '2', 'Test: every 5 seconds', 2, '[{"changed": {"fields": ["args"]}}]', 23, 1),(4, '2018-06-12 15:45:10.737056+08', '2', 'Test: every 5 seconds', 2, '[{"changed": {"fields": ["args"]}}]', 23, 1),(5, '2018-06-12 15:46:00.339906+08', '2', 'Test: every 5 seconds', 2, '[{"changed": {"fields": ["args"]}}]', 23, 1),(6, '2018-06-13 11:07:44.122559+08', '2', 'Test: every 5 seconds', 2, '[{"changed": {"fields": ["regtask", "task"]}}]', 23, 1),(7, '2018-06-13 16:19:49.869459+08', '2', 'Test: every 5 seconds', 2, '[{"changed": {"fields": ["queue"]}}]', 23, 1),(8, '2018-06-13 16:57:56.870846+08', '3', 'TT: every 5 seconds', 1, '[{"added": {}}]', 23, 1),(9, '2018-06-13 16:58:22.178425+08', '2', 'Test: every 5 seconds', 3, '', 23, 1),(10, '2018-06-13 17:24:51.339456+08', '3', 'TT: every 5 seconds', 2, '[{"changed": {"fields": ["regtask", "task"]}}]', 23, 1),(11, '2018-06-13 17:26:29.546608+08', '4', 'Test: every 5 seconds', 1, '[{"added": {}}]', 23, 1),(12, '2018-06-13 17:33:45.062475+08', '4', 'Test: every 5 seconds', 3, '', 23, 1),(13, '2018-06-14 17:16:01.393474+08', '3', 'TT: every 5 seconds', 3, '', 23, 1),(14, '2018-06-14 17:16:14.237058+08', '2', 'every 30 seconds', 1, '[{"added": {}}]', 22, 1),(15, '2018-06-14 17:16:51.337441+08', '5', 'PING: every 30 seconds', 1, '[{"added": {}}]', 23, 1),(16, '2018-06-15 09:08:51.903879+08', '3', 'every 5 minutes', 1, '[{"added": {}}]', 22, 1),(17, '2018-06-15 09:09:02.37659+08', '5', 'PING: every 5 minutes', 2, '[{"changed": {"fields": ["interval"]}}]', 23, 1),(18, '2018-06-15 09:09:26.362323+08', '6', 'Scheduler: every 5 minutes', 1, '[{"added": {}}]', 23, 1),(19, '2018-06-15 09:10:56.472088+08', '6', 'Scheduler: every 5 seconds', 2, '[{"changed": {"fields": ["interval"]}}]', 23, 1),(20, '2018-06-15 09:11:47.654317+08', '6', 'Scheduler: every 30 seconds', 2, '[{"changed": {"fields": ["interval"]}}]', 23, 1);
COMMIT;
BEGIN;
LOCK TABLE "public"."django_content_type" IN SHARE MODE;
DELETE FROM "public"."django_content_type";
INSERT INTO "public"."django_content_type" ("id","app_label","model") VALUES (1, 'admin', 'logentry'),(2, 'auth', 'permission'),(3, 'auth', 'group'),(4, 'auth', 'user'),(5, 'contenttypes', 'contenttype'),(6, 'sessions', 'session'),(7, 'BroadviewCOSS', 'category'),(8, 'BroadviewCOSS', 'mainframe'),(9, 'BroadviewCOSS', 'menu'),(10, 'BroadviewCOSS', 'menurole'),(11, 'BroadviewCOSS', 'operationlog'),(12, 'BroadviewCOSS', 'permission'),(13, 'BroadviewCOSS', 'role'),(14, 'BroadviewCOSS', 'rolepermission'),(15, 'BroadviewCOSS', 'task'),(16, 'BroadviewCOSS', 'taskcategory'),(17, 'BroadviewCOSS', 'taskmainframe'),(18, 'BroadviewCOSS', 'taskrun'),(19, 'BroadviewCOSS', 'user'),(20, 'BroadviewCOSS', 'userrole'),(21, 'djcelery', 'crontabschedule'),(22, 'djcelery', 'intervalschedule'),(23, 'djcelery', 'periodictask'),(24, 'djcelery', 'periodictasks'),(25, 'djcelery', 'taskmeta'),(26, 'djcelery', 'tasksetmeta'),(27, 'djcelery', 'taskstate'),(28, 'djcelery', 'workerstate');
COMMIT;
BEGIN;
LOCK TABLE "public"."django_migrations" IN SHARE MODE;
DELETE FROM "public"."django_migrations";
INSERT INTO "public"."django_migrations" ("id","app","name","applied") VALUES (1, 'BroadviewCOSS', '0001_initial', '2018-06-12 14:33:42.498723+08'),(2, 'contenttypes', '0001_initial', '2018-06-12 14:33:42.619647+08'),(3, 'auth', '0001_initial', '2018-06-12 14:33:43.631067+08'),(4, 'admin', '0001_initial', '2018-06-12 14:33:43.729022+08'),(5, 'admin', '0002_logentry_remove_auto_add', '2018-06-12 14:33:43.737014+08'),(6, 'contenttypes', '0002_remove_content_type_name', '2018-06-12 14:33:43.759991+08'),(7, 'auth', '0002_alter_permission_name_max_length', '2018-06-12 14:33:43.764989+08'),(8, 'auth', '0003_alter_user_email_max_length', '2018-06-12 14:33:43.773003+08'),(9, 'auth', '0004_alter_user_username_opts', '2018-06-12 14:33:43.78099+08'),(10, 'auth', '0005_alter_user_last_login_null', '2018-06-12 14:33:43.789984+08'),(11, 'auth', '0006_require_contenttypes_0002', '2018-06-12 14:33:43.791974+08'),(12, 'auth', '0007_alter_validators_add_error_messages', '2018-06-12 14:33:43.800977+08'),(13, 'auth', '0008_alter_user_username_max_length', '2018-06-12 14:33:43.840955+08'),(14, 'auth', '0009_alter_user_last_name_max_length', '2018-06-12 14:33:43.848953+08'),(15, 'djcelery', '0001_initial', '2018-06-12 14:33:45.272122+08'),(16, 'sessions', '0001_initial', '2018-06-12 14:33:45.389055+08'),(17, 'BroadviewCOSS', '0002_auto_20180615_1603', '2018-06-15 16:03:50.369758+08');
COMMIT;
BEGIN;
LOCK TABLE "public"."django_session" IN SHARE MODE;
DELETE FROM "public"."django_session";
INSERT INTO "public"."django_session" ("session_key","session_data","expire_date") VALUES ('wlawt8j0uuadsk5d8773jy4oy5uu280l', 'NWZkNWE3MGUwNWUyNGM1MTI0ZmRmN2UyNDZhODBhYjExYjA4NzEzMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzAyMzdiZGU0YzQ1MTNmMzlkODYyZWJkODI0YjAzYjBlOTYwN2Y3IiwidXNlcm5hbWUiOiJ5eWxoYmIiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDB9', '2018-06-12 16:41:08.696485+08'),('plg5f7mzfdi1h5a43zfgv5za5s54sos9', 'NWZkNWE3MGUwNWUyNGM1MTI0ZmRmN2UyNDZhODBhYjExYjA4NzEzMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzAyMzdiZGU0YzQ1MTNmMzlkODYyZWJkODI0YjAzYjBlOTYwN2Y3IiwidXNlcm5hbWUiOiJ5eWxoYmIiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDB9', '2018-06-14 12:53:07.141798+08'),('q7pc09b2gm3bnyme0ghvp2wqvxs9vhrl', 'NWZkNWE3MGUwNWUyNGM1MTI0ZmRmN2UyNDZhODBhYjExYjA4NzEzMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzAyMzdiZGU0YzQ1MTNmMzlkODYyZWJkODI0YjAzYjBlOTYwN2Y3IiwidXNlcm5hbWUiOiJ5eWxoYmIiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDB9', '2018-06-14 19:17:07.601083+08'),('ej65icca0klbmp1r81xwlzz44vk7pnv0', 'OGQxOTFiOTFjZWRhODIwYTNhYjVhMDhiZTJjNWVkYTcxODFhNzQzYzp7InVzZXJuYW1lIjoieXlsaGJiIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzcwMjM3YmRlNGM0NTEzZjM5ZDg2MmViZDgyNGIwM2IwZTk2MDdmNyJ9', '2018-06-15 11:08:40.442382+08'),('d2umhptd4i6nnfkcixyy5zp2bdxa25jm', 'NGNhMmNkOWM5OTBjOGE3NTFlZmU0Y2U5MWZlY2UxYTM4OGE5N2NlMjp7InVzZXJuYW1lIjoieXlsaGJiIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==', '2018-06-15 13:10:09.314507+08'),('uxx1vt7quvosrex37uf9tbvqsb8lhwii', 'NGNhMmNkOWM5OTBjOGE3NTFlZmU0Y2U5MWZlY2UxYTM4OGE5N2NlMjp7InVzZXJuYW1lIjoieXlsaGJiIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==', '2018-06-15 16:56:39.152004+08');
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_crontabschedule" IN SHARE MODE;
DELETE FROM "public"."djcelery_crontabschedule";
INSERT INTO "public"."djcelery_crontabschedule" ("id","minute","hour","day_of_week","day_of_month","month_of_year") VALUES (1, '0', '4', '*', '*', '*');
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_intervalschedule" IN SHARE MODE;
DELETE FROM "public"."djcelery_intervalschedule";
INSERT INTO "public"."djcelery_intervalschedule" ("id","every","period") VALUES (1, 5, 'seconds'),(2, 30, 'seconds'),(3, 5, 'minutes');
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_periodictask" IN SHARE MODE;
DELETE FROM "public"."djcelery_periodictask";
INSERT INTO "public"."djcelery_periodictask" ("id","name","task","args","kwargs","queue","exchange","routing_key","expires","enabled","last_run_at","total_run_count","date_changed","description","crontab_id","interval_id") VALUES (1, 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', NULL, NULL, NULL, NULL, 't', NULL, 0, '2018-06-15 16:15:35.538496+08', '', 1, NULL),(5, 'PING', 'BroadviewCOSS.tasks.ping', '[]', '{}', NULL, NULL, NULL, NULL, 't', '2018-06-15 16:30:55.866913+08', 60, '2018-06-15 16:34:00.654268+08', '', NULL, 3),(6, 'Scheduler', 'BroadviewCOSS.tasks.scheduler', '[]', '{}', NULL, NULL, NULL, NULL, 't', '2018-06-15 16:34:05.691053+08', 214, '2018-06-15 16:34:29.494078+08', '', NULL, 2);
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_periodictasks" IN SHARE MODE;
DELETE FROM "public"."djcelery_periodictasks";
INSERT INTO "public"."djcelery_periodictasks" ("ident","last_update") VALUES (1, '2018-06-15 16:15:35.445564+08');
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_taskstate" IN SHARE MODE;
DELETE FROM "public"."djcelery_taskstate";
COMMIT;
BEGIN;
LOCK TABLE "public"."djcelery_workerstate" IN SHARE MODE;
DELETE FROM "public"."djcelery_workerstate";
COMMIT;
ALTER TABLE "public"."Category" ADD CONSTRAINT "Category_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."Mainframe" ADD CONSTRAINT "Mainframe_status_check" CHECK ((status >= 0));
ALTER TABLE "public"."Mainframe" ADD CONSTRAINT "Mainframe_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."Mainframe" ADD CONSTRAINT "Mainframe_category_96f7e326_fk_Category_id" FOREIGN KEY ("category") REFERENCES "public"."Category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "Mainframe_category_96f7e326" ON "public"."Mainframe" USING btree (
  "category" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."MenuRole" ADD CONSTRAINT "MenuRole_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."MenuRole" ADD CONSTRAINT "MenuRole_menu_b87a97ce_fk_Menu_id" FOREIGN KEY ("menu") REFERENCES "public"."Menu" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."MenuRole" ADD CONSTRAINT "MenuRole_role_cc0df690_fk_Role_id" FOREIGN KEY ("role") REFERENCES "public"."Role" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "MenuRole_menu_b87a97ce" ON "public"."MenuRole" USING btree (
  "menu" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "MenuRole_role_cc0df690" ON "public"."MenuRole" USING btree (
  "role" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."Menu" ADD CONSTRAINT "Menu_parent_check" CHECK ((parent >= 0));
ALTER TABLE "public"."Menu" ADD CONSTRAINT "Menu_sub_check" CHECK ((sub >= 0));
ALTER TABLE "public"."Menu" ADD CONSTRAINT "Menu_index_check" CHECK ((index >= 0));
ALTER TABLE "public"."Menu" ADD CONSTRAINT "Menu_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."OperationLog" ADD CONSTRAINT "OperationLog_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."OperationLog" ADD CONSTRAINT "OperationLog_user_dc7617f8_fk_User_id" FOREIGN KEY ("user") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "OperationLog_user_dc7617f8" ON "public"."OperationLog" USING btree (
  "user" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."Permission" ADD CONSTRAINT "Permission_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."RolePermission" ADD CONSTRAINT "RolePermission_role_key" UNIQUE ("role");
ALTER TABLE "public"."RolePermission" ADD CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."RolePermission" ADD CONSTRAINT "RolePermission_permission_60b1049c_fk_Permission_id" FOREIGN KEY ("permission") REFERENCES "public"."Permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."RolePermission" ADD CONSTRAINT "RolePermission_role_a3c28319_fk_Role_id" FOREIGN KEY ("role") REFERENCES "public"."Role" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "RolePermission_permission_60b1049c" ON "public"."RolePermission" USING btree (
  "permission" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."Role" ADD CONSTRAINT "Role_name_key" UNIQUE ("name");
ALTER TABLE "public"."Role" ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("id");
CREATE INDEX "Role_name_9918a78c_like" ON "public"."Role" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."TaskCategory" ADD CONSTRAINT "TaskCategory_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."TaskCategory" ADD CONSTRAINT "TaskCategory_category_a63cc6a4_fk_Category_id" FOREIGN KEY ("category") REFERENCES "public"."Category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."TaskCategory" ADD CONSTRAINT "TaskCategory_task_ef8ac79f_fk_Task_id" FOREIGN KEY ("task") REFERENCES "public"."Task" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "TaskCategory_category_a63cc6a4" ON "public"."TaskCategory" USING btree (
  "category" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "TaskCategory_task_ef8ac79f" ON "public"."TaskCategory" USING btree (
  "task" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."TaskMainframe" ADD CONSTRAINT "TaskMainframe_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."TaskMainframe" ADD CONSTRAINT "TaskMainframe_mainframe_a9c6fa3e_fk_Mainframe_id" FOREIGN KEY ("mainframe") REFERENCES "public"."Mainframe" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."TaskMainframe" ADD CONSTRAINT "TaskMainframe_task_ba175686_fk_Task_id" FOREIGN KEY ("task") REFERENCES "public"."Task" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "TaskMainframe_mainframe_a9c6fa3e" ON "public"."TaskMainframe" USING btree (
  "mainframe" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "TaskMainframe_task_ba175686" ON "public"."TaskMainframe" USING btree (
  "task" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."TaskRun" ADD CONSTRAINT "TaskRun_status_check" CHECK ((status >= 0));
ALTER TABLE "public"."TaskRun" ADD CONSTRAINT "TaskRun_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."TaskRun" ADD CONSTRAINT "TaskRun_task_7ad53eb9_fk_Task_id" FOREIGN KEY ("task") REFERENCES "public"."Task" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."TaskRun" ADD CONSTRAINT "TaskRun_user_96081407_fk_User_id" FOREIGN KEY ("user") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "TaskRun_task_7ad53eb9" ON "public"."TaskRun" USING btree (
  "task" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "TaskRun_user_96081407" ON "public"."TaskRun" USING btree (
  "user" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."Task" ADD CONSTRAINT "Task_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."Task" ADD CONSTRAINT "Task_user_b429d871_fk_User_id" FOREIGN KEY ("user") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "Task_user_b429d871" ON "public"."Task" USING btree (
  "user" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."UserRole" ADD CONSTRAINT "UserRole_user_key" UNIQUE ("user");
ALTER TABLE "public"."UserRole" ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."UserRole" ADD CONSTRAINT "UserRole_role_62f39914_fk_Role_id" FOREIGN KEY ("role") REFERENCES "public"."Role" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."UserRole" ADD CONSTRAINT "UserRole_user_dab2028c_fk_User_id" FOREIGN KEY ("user") REFERENCES "public"."User" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "UserRole_role_62f39914" ON "public"."UserRole" USING btree (
  "role" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."User" ADD CONSTRAINT "User_username_key" UNIQUE ("username");
ALTER TABLE "public"."User" ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
CREATE INDEX "User_username_3851fdce_like" ON "public"."User" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_group" ADD CONSTRAINT "auth_group_name_key" UNIQUE ("name");
ALTER TABLE "public"."auth_group" ADD CONSTRAINT "auth_group_pkey" PRIMARY KEY ("id");
CREATE INDEX "auth_group_name_a6ea08ec_like" ON "public"."auth_group" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" UNIQUE ("group_id", "permission_id");
ALTER TABLE "public"."auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."auth_group_permissions" ADD CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "public"."auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "public"."auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "public"."auth_group_permissions" USING btree (
  "group_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "public"."auth_group_permissions" USING btree (
  "permission_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_permission" ADD CONSTRAINT "auth_permission_content_type_id_codename_01ab375a_uniq" UNIQUE ("content_type_id", "codename");
ALTER TABLE "public"."auth_permission" ADD CONSTRAINT "auth_permission_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."auth_permission" ADD CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "public"."django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "public"."auth_permission" USING btree (
  "content_type_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_user" ADD CONSTRAINT "auth_user_username_key" UNIQUE ("username");
ALTER TABLE "public"."auth_user" ADD CONSTRAINT "auth_user_pkey" PRIMARY KEY ("id");
CREATE INDEX "auth_user_username_6821ab7c_like" ON "public"."auth_user" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_user_groups" ADD CONSTRAINT "auth_user_groups_user_id_group_id_94350c0c_uniq" UNIQUE ("user_id", "group_id");
ALTER TABLE "public"."auth_user_groups" ADD CONSTRAINT "auth_user_groups_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."auth_user_groups" ADD CONSTRAINT "auth_user_groups_group_id_97559544_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "public"."auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."auth_user_groups" ADD CONSTRAINT "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "auth_user_groups_group_id_97559544" ON "public"."auth_user_groups" USING btree (
  "group_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "public"."auth_user_groups" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."auth_user_user_permissions" ADD CONSTRAINT "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" UNIQUE ("user_id", "permission_id");
ALTER TABLE "public"."auth_user_user_permissions" ADD CONSTRAINT "auth_user_user_permissions_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."auth_user_user_permissions" ADD CONSTRAINT "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "public"."auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."auth_user_user_permissions" ADD CONSTRAINT "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "public"."auth_user_user_permissions" USING btree (
  "permission_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "public"."auth_user_user_permissions" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."celery_taskmeta" ADD CONSTRAINT "celery_taskmeta_task_id_key" UNIQUE ("task_id");
ALTER TABLE "public"."celery_taskmeta" ADD CONSTRAINT "celery_taskmeta_pkey" PRIMARY KEY ("id");
CREATE INDEX "celery_taskmeta_hidden_23fd02dc" ON "public"."celery_taskmeta" USING btree (
  "hidden" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "celery_taskmeta_task_id_9558b198_like" ON "public"."celery_taskmeta" USING btree (
  "task_id" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."celery_tasksetmeta" ADD CONSTRAINT "celery_tasksetmeta_taskset_id_key" UNIQUE ("taskset_id");
ALTER TABLE "public"."celery_tasksetmeta" ADD CONSTRAINT "celery_tasksetmeta_pkey" PRIMARY KEY ("id");
CREATE INDEX "celery_tasksetmeta_hidden_593cfc24" ON "public"."celery_tasksetmeta" USING btree (
  "hidden" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "celery_tasksetmeta_taskset_id_a5a1d4ae_like" ON "public"."celery_tasksetmeta" USING btree (
  "taskset_id" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."django_admin_log" ADD CONSTRAINT "django_admin_log_action_flag_check" CHECK ((action_flag >= 0));
ALTER TABLE "public"."django_admin_log" ADD CONSTRAINT "django_admin_log_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."django_admin_log" ADD CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "public"."django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."django_admin_log" ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk" FOREIGN KEY ("user_id") REFERENCES "public"."auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "public"."django_admin_log" USING btree (
  "content_type_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "public"."django_admin_log" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."django_content_type" ADD CONSTRAINT "django_content_type_app_label_model_76bd3d3b_uniq" UNIQUE ("app_label", "model");
ALTER TABLE "public"."django_content_type" ADD CONSTRAINT "django_content_type_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."django_migrations" ADD CONSTRAINT "django_migrations_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."django_session" ADD CONSTRAINT "django_session_pkey" PRIMARY KEY ("session_key");
CREATE INDEX "django_session_expire_date_a5c62663" ON "public"."django_session" USING btree (
  "expire_date" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "django_session_session_key_c0390e0f_like" ON "public"."django_session" USING btree (
  "session_key" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."djcelery_crontabschedule" ADD CONSTRAINT "djcelery_crontabschedule_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."djcelery_intervalschedule" ADD CONSTRAINT "djcelery_intervalschedule_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."djcelery_periodictask" ADD CONSTRAINT "djcelery_periodictask_name_key" UNIQUE ("name");
ALTER TABLE "public"."djcelery_periodictask" ADD CONSTRAINT "djcelery_periodictask_total_run_count_check" CHECK ((total_run_count >= 0));
ALTER TABLE "public"."djcelery_periodictask" ADD CONSTRAINT "djcelery_periodictask_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."djcelery_periodictask" ADD CONSTRAINT "djcelery_periodictas_crontab_id_75609bab_fk_djcelery_" FOREIGN KEY ("crontab_id") REFERENCES "public"."djcelery_crontabschedule" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "public"."djcelery_periodictask" ADD CONSTRAINT "djcelery_periodictas_interval_id_b426ab02_fk_djcelery_" FOREIGN KEY ("interval_id") REFERENCES "public"."djcelery_intervalschedule" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "djcelery_periodictask_crontab_id_75609bab" ON "public"."djcelery_periodictask" USING btree (
  "crontab_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_periodictask_interval_id_b426ab02" ON "public"."djcelery_periodictask" USING btree (
  "interval_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_periodictask_name_cb62cda9_like" ON "public"."djcelery_periodictask" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
ALTER TABLE "public"."djcelery_periodictasks" ADD CONSTRAINT "djcelery_periodictasks_pkey" PRIMARY KEY ("ident");
ALTER TABLE "public"."djcelery_taskstate" ADD CONSTRAINT "djcelery_taskstate_task_id_key" UNIQUE ("task_id");
ALTER TABLE "public"."djcelery_taskstate" ADD CONSTRAINT "djcelery_taskstate_pkey" PRIMARY KEY ("id");
ALTER TABLE "public"."djcelery_taskstate" ADD CONSTRAINT "djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_" FOREIGN KEY ("worker_id") REFERENCES "public"."djcelery_workerstate" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "djcelery_taskstate_hidden_c3905e57" ON "public"."djcelery_taskstate" USING btree (
  "hidden" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_name_8af9eded" ON "public"."djcelery_taskstate" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_name_8af9eded_like" ON "public"."djcelery_taskstate" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_state_53543be4" ON "public"."djcelery_taskstate" USING btree (
  "state" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_state_53543be4_like" ON "public"."djcelery_taskstate" USING btree (
  "state" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_task_id_9d2efdb5_like" ON "public"."djcelery_taskstate" USING btree (
  "task_id" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_tstamp_4c3f93a1" ON "public"."djcelery_taskstate" USING btree (
  "tstamp" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_taskstate_worker_id_f7f57a05" ON "public"."djcelery_taskstate" USING btree (
  "worker_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
ALTER TABLE "public"."djcelery_workerstate" ADD CONSTRAINT "djcelery_workerstate_hostname_key" UNIQUE ("hostname");
ALTER TABLE "public"."djcelery_workerstate" ADD CONSTRAINT "djcelery_workerstate_pkey" PRIMARY KEY ("id");
CREATE INDEX "djcelery_workerstate_hostname_b31c7fab_like" ON "public"."djcelery_workerstate" USING btree (
  "hostname" COLLATE "pg_catalog"."default" "pg_catalog"."varchar_pattern_ops" ASC NULLS LAST
);
CREATE INDEX "djcelery_workerstate_last_heartbeat_4539b544" ON "public"."djcelery_workerstate" USING btree (
  "last_heartbeat" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
