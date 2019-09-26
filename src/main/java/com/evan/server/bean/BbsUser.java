package com.evan.server.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户信息表
 * </p>
 *
 * @author geoffrey
 * @since 2019-09-25
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class BbsUser implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    /**
     * 用户昵称
     */
    private String userName;

    private String userPwd;

    private String userEmail;

    /**
     * 用户性别
     */
    private String userSex;

    /**
     * 电话
     */
    private Integer userPhone;

    /**
     * 用户类型
     */
    private Integer userStatus;

    /**
     * 用户经验
     */
    private String userEx;

    /**
     * 注册时间/更改时间
     */
    private LocalDateTime userTime;

    /**
     * 用户签名
     */
    private String userShow;

    /**
     * 用户主页链接
     */
    private String userBlog;

    /**
     * 用户头像
     */
    private String userImg;

    /**
     * 用户粉丝数
     */
    private Integer userFans;

    /**
     * 用户关注别人的数量
     */
    private Integer userConcern;


}
