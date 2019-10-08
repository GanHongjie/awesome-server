# ********************************
#
# Create By EvanGan on 2019-9-6
# MySQL version : 8.0.15
#
# ********************************


# -------------------------------
# create database
# -------------------------------
drop database if exists evan_server;
create database evan_server;
use evan_server;

# -------------------------------
# admin table
# -------------------------------


# -------------------------------
# user table
# -------------------------------
drop table if exists bbs_user;
create table bbs_user
(
    user_id      int(11)     not null auto_increment,
    user_name    varchar(50)  default null comment '用户昵称',
    user_pwd     varchar(50) not null,
    user_email   varchar(50)  default null,
    user_sex     varchar(2)   default null comment '用户性别',
    user_phone   int(11)      default null comment '电话',
    user_status  int(1)       default null comment '用户类型',
    user_ex      varchar(255) default null comment '用户经验',
    user_time    datetime     default current_timestamp comment '注册时间/更改时间',
    user_show    varchar(255) default null comment '用户签名',
    user_blog    varchar(255) default null comment '用户主页链接',
    user_img     varchar(255) default null comment '用户头像',
    user_fans    int(11)      default null comment '用户粉丝数',
    user_concern int(11)      default null comment '用户关注别人的数量',
    primary key (user_id)
) engine = innodb default charset = utf8 comment ='用户信息表';

# -------------------------------
# article  type table
# -------------------------------
drop table if exists bbs_article_type;
create table bbs_article_type
(
    type_id          int(11) not null,
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
    art_id         int(11) not null comment '文章的id',
    art_user_id    int(11)      default null comment '用户名id',
    art_title      varchar(255) default null comment '标题',
    art_type_id    int(11)      default null comment '类型id',
    art_content    text comment '正文',
    art_comment_id int(11)      default null comment '评论id',
    art_cre_time   datetime     default current_timestamp comment '创建时间',
    art_view       int(11)      default null comment '浏览量',
    art_com_num    int(11)      default null comment '评论数',
    art_hot_num    int(11)      default null comment '当日浏览量/热度',
    art_like_num   int(11)      default null comment '点赞数',
    primary key (art_id),
    key type_index (art_type_id),
    key com_index (art_comment_id),
    key art_index (art_user_id),
    constraint art_index foreign key (art_user_id) references bbs_user (user_id) on delete no action on update no action,
    constraint type_index foreign key (art_type_id) references bbs_article_type (type_id) on delete no action on update no action
) default charset = utf8 comment ='文章表';

# -------------------------------
# attention table
# -------------------------------
drop table if exists bbs_attention;
create table bbs_attention
(
    att_id        int(11) not null,
    att_author_id int(11) default null comment '关注人id',
    att_user_id   int(11) default null,
    primary key (att_id),
    key attention_index (att_user_id) using btree,
    key attention_author_index (att_author_id),
    constraint attention_author_index foreign key (att_author_id) references bbs_user (user_id) on delete set null on update no action,
    constraint attention_user_index foreign key (att_user_id) references bbs_user (user_id) on delete set null on update no action
) engine = innodb
  default charset = utf8 comment ='关注表';

# -------------------------------
# collection table
# -------------------------------
drop table if exists bbs_collect;
create table bbs_collect
(
    col_id      int(11) not null,
    col_art_id  int(11) default null comment '收藏文章id',
    col_user_id int(11) default null comment '收藏用户的id/谁收藏了文章',
    primary key (col_id),
    key col_index (col_user_id),
    key col_art_index (col_art_id),
    constraint col_art_index foreign key (col_art_id) references bbs_article (art_id) on delete no action on update no action,
    constraint col_index foreign key (col_user_id) references bbs_user (user_id) on delete no action on update cascade
) engine = innodb
  default charset = utf8 comment ='文章收藏表';


# -------------------------------
# comment table
# -------------------------------
drop table if exists bbs_comment;
create table bbs_comment
(
    com_id      int(11) not null,
    com_content varchar(255) default null comment '评论正文',
    com_art_id  int(11)      default null comment '文章id',
    com_user_id int(11)      default null comment '评论用户的id',
    com_time    datetime     default current_timestamp comment '评论时间',
    primary key (com_id),
    key com_user_index (com_user_id),
    key com_art_index (com_art_id),
    constraint com_art_index foreign key (com_art_id) references bbs_article (art_id) on delete no action on update no action,
    constraint com_user_index foreign key (com_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='一级评论表';

# -------------------------------
# multi comment table
# -------------------------------
drop table if exists bbs_comment_multi;
create table bbs_comment_multi
(
    com_multi_id      int(11) not null,
    com_id            int(11) not null comment '一级评论id',
    com_multi_content varchar(255) default null,
    com_multi_user_id int(11) not null comment '多级评论用户id',
    com_multi_time    datetime     default current_timestamp,
    primary key (com_multi_id),
    key multi_user_index (com_multi_user_id),
    key multi_com_index (com_id),
    constraint multi_com_index foreign key (com_id) references bbs_comment (com_id) on delete no action on update no action,
    constraint multi_user_index foreign key (com_multi_user_id) references bbs_user (user_id) on delete no action on update no action
) engine = innodb
  default charset = utf8 comment ='多级评论表';
