# ********************************
#
# Create By EvanGan on 2019-9-6
# MySQL version : 8.0.15
#
# ********************************


# -------------------------------
# create database
# -------------------------------
drop database if exists bbs;
create database bbs;
use bbs;
# -------------------------------
#  user table
# -------------------------------

drop table if exists bbs_user;
create table bbs_user
(
    user_id     int(11)     not null auto_increment comment '用户学号，主键',
    user_name   varchar(50) default null comment '用户姓名',
    user_pwd    varchar(50) not null comment '用户密码',
    user_sex    varchar(2)  default null comment '用户性别',
    user_status int(1)      default null comment '用户类型,1代表admin,2代表teacher,3代表student',
    user_time   datetime    default current_timestamp comment '注册时间',
    primary key (user_id)
) engine = innodb
  default charset = utf8 comment ='用户信息表';

# -------------------------------
#  user_blog_info table
# -------------------------------
drop table if exists bbs_user_blog_info;
create table bbs_user_blog_info
(
    user_blog_info_id      int(11) not null auto_increment comment '主键',
    user_blog_info_user_id int(11) comment '用户id,指向user表',
    user_blog_info_name    varchar(50)  default null comment '用户昵称',
    user_blog_info_ex      varchar(255) default null comment '用户经验',
    user_blog_info_show    varchar(255) default null comment '用户签名',
    user_blog_info_blog    varchar(255) default null comment '用户主页链接',
    user_blog_info_img     varchar(255) default null comment '用户头像',
    user_blog_info_fans    int(11)      default null comment '用户粉丝数',
    user_blog_info_concern int(11)      default null comment '用户关注别人的数量',
    constraint user_blog_info_user_id_con foreign key (user_blog_info_user_id) references bbs_user (user_id) on delete no action on update no action,
    primary key (user_blog_info_id)
) engine = innodb
  default charset = utf8 comment ='用户博客信息表';


# -------------------------------
# article  type table
# -------------------------------
drop table if exists bbs_article_type;
create table bbs_article_type
(
    type_id          int(11) not null comment '主键',
    type_name        varchar(255) default null comment '标签/类型',
    type_create_time datetime     default current_timestamp comment '创建时间',
    primary key (type_id)
) engine = innodb
  default charset = utf8 comment ='文章类型表/标签表';


# -------------------------------
# article table
# -------------------------------
drop table if exists bbs_article;
create table bbs_article
(
    art_id       int(11) not null comment '文章的id，主键',
    art_user_id  int(11)      default null comment '用户名id,指向user表',
    art_title    varchar(255) default null comment '标题',
    art_type_id  int(11)      default null comment '类型id,指向article表',
    art_content  text comment '正文',
    art_pub_time datetime     default current_timestamp comment '创建时间',
    art_view     int(11)      default null comment '浏览量',
    art_com_num  int(11)      default null comment '评论数',
    art_hot_num  int(11)      default null comment '当日浏览量/热度',
    art_like_num int(11)      default null comment '点赞数',
    primary key (art_id),
    key article_type_id_index (art_type_id),
    key article_user_id_index (art_user_id),
    constraint article_user_id_con foreign key (art_user_id) references bbs_user (user_id) on delete no action on update no action,
    constraint article_type_id_con foreign key (art_type_id) references bbs_article_type (type_id) on delete no action on update no action
) default charset = utf8 comment ='文章表';



# -------------------------------
# resource table
# -------------------------------
drop table if exists bbs_resource;
create table bbs_resource
(
    res_id     int(11) not null comment '主键',
    res_url    varchar(255) default null comment '网址',
    res_art_id int(11),
    constraint res_id_con foreign key (res_art_id) references bbs_article (art_id) on delete no action on update no action,
    primary key (res_id)
) engine = innodb
  default charset = utf8 comment ='文章类型表/标签表';

# -------------------------------
# attention table
# -------------------------------
drop table if exists bbs_attention;
create table bbs_attention
(
    att_id        int(11) not null comment '主键',
    att_author_id int(11) default null comment '他人的id',
    att_user_id   int(11) default null comment '当前用户id',
    primary key (att_id),
    key attention_user_id_index (att_user_id) using btree,
    key attention_author_id_index (att_author_id),
    constraint attention_author_id_con foreign key (att_author_id) references bbs_user (user_id) on delete set null on update no action,
    constraint attention_user_id_con foreign key (att_user_id) references bbs_user (user_id) on delete set null on update no action
) engine = innodb
  default charset = utf8 comment ='关注表';

# -------------------------------
# collection table
# -------------------------------
drop table if exists bbs_collect;
create table bbs_collect
(
    col_id      int(11) not null comment '主键',
    col_art_id  int(11) default null comment '收藏文章id',
    col_user_id int(11) default null comment '收藏用户的id/谁收藏了文章',
    primary key (col_id),
    key collect_user_id_index (col_user_id),
    key collect_art_id_index (col_art_id),
    constraint collect_art_id_con foreign key (col_art_id) references bbs_article (art_id) on delete no action on update no action,
    constraint collect_user_id_con foreign key (col_user_id) references bbs_user (user_id) on delete no action on update cascade
) engine = innodb
  default charset = utf8 comment ='文章收藏表';


# -------------------------------
# comment table
# -------------------------------
drop table if exists bbs_comment;
create table bbs_comment
(
    com_id      int(11) not null comment '主键',
    com_content varchar(255) default null comment '评论正文',
    com_art_id  int(11)      default null comment '文章id',
    com_user_id int(11)      default null comment '评论用户的id',
    com_time    datetime     default current_timestamp comment '评论时间',
    primary key (com_id),
    key comment_user_id_index (com_user_id),
    key comment_art_id_index (com_art_id),
    constraint comment_art_id_con foreign key (com_art_id) references bbs_article (art_id) on delete no action on update no action,
    constraint comment_user_id_con foreign key (com_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='一级评论表';

# -------------------------------
# multi comment table
# -------------------------------
drop table if exists bbs_comment_multi;
create table bbs_comment_multi
(
    com_multi_id      int(11) not null comment '主键',
    com_id            int(11) not null comment '一级评论id',
    com_multi_content varchar(255) default null,
    com_multi_user_id int(11) not null comment '多级评论用户id',
    com_multi_time    datetime     default current_timestamp,
    primary key (com_multi_id),
    key comment_multi_user_id_index (com_multi_user_id),
    key comment_multi_id_index (com_id),
    constraint comment_multi_id_con foreign key (com_id) references bbs_comment (com_id) on delete no action on update no action,
    constraint comment_multi_user_id_con foreign key (com_multi_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='多级评论表';


# -------------------------------
# teacher publish task table
# -------------------------------
drop table if exists bbs_teacher_task;
create table bbs_teacher_task
(
    teacher_task_id       int(11) not null comment '主键',
    teacher_task_pub_time datetime     default current_timestamp comment '发布的时间',
    teacher_task_end_time datetime     default null comment '截止时间',
    teacher_task_state    int(1) comment '老师发布任务状态，是否过了截止时间',
    teacher_task_user_id  int(11) comment '老师的用户id',
    teacher_task_title    varchar(255) default null comment '标题',
    teacher_task_content  text comment '正文',
    primary key (teacher_task_id),
    constraint teacher_task_user_id_con foreign key (teacher_task_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='老师发布任务表';

# -------------------------------
# student task table
# -------------------------------
drop table if exists bbs_student_task;
create table bbs_student_task
(
    student_task_id         int(11) comment '主键',
    student_task_group_id   int(11) default null comment '小组id，若为null，则不分组',
    student_task_teacher_id int(11) comment '老师发布作业的id',
    student_task_user_id    int(11) comment '学生在user表的id',
    primary key (student_task_id),
    constraint student_task_teacher_id_con foreign key (student_task_teacher_id) references bbs_teacher_task (teacher_task_id) on delete no action on update no action,
    constraint student_task_user_id_con foreign key (student_task_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='学生任务表';

# -------------------------------
#  task table
# -------------------------------
drop table if exists bbs_task;
create table bbs_task
(
    task_id      int(11) comment '主键,指向student_task表的id',
    task_content text comment '正文',
    primary key (task_id),
    constraint task_id_con foreign key (task_id) references bbs_student_task (student_task_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='学生作业表';


# -------------------------------
#  task resource table
# -------------------------------
drop table if exists bbs_task_resource;
create table bbs_task_resource
(
    task_resource_id  int(11) comment '主键,指向task表的id',
    task_resource_url varchar(255) not null comment '学生上传资源的地址',
    primary key (task_resource_id),
    constraint task_resource_id_con foreign key (task_resource_id) references bbs_student_task (student_task_id) on delete no action on update no action
) engine = innodb comment ='学生作业资源表';

# -------------------------------
#  task resource table
# -------------------------------
drop table if exists test;
create table test
(
    task_resource_id  int(11) comment '主键,指向task表的id',
    task_resource_url varchar(255) comment '学生上传资源的地址',
    primary key (task_resource_id, task_resource_url)
) engine = innodb;
# -------------------------------
#  task resource table
# -------------------------------
drop table if exists test;
create table test
(
    task_resource_id  int(11) comment '主键,指向task表的id',
    task_resource_url varchar(255) comment '学生上传资源的地址',
    primary key (task_resource_id, task_resource_url)
) engine = innodb
