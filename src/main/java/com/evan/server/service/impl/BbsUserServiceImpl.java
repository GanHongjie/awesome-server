package com.evan.server.service.impl;

import com.evan.server.bean.BbsUser;
import com.evan.server.mapper.BbsUserMapper;
import com.evan.server.service.BbsUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户信息表 服务实现类
 * </p>
 *
 * @author geoffrey
 * @since 2019-09-25
 */
@Service
public class BbsUserServiceImpl extends ServiceImpl<BbsUserMapper, BbsUser> implements BbsUserService {


}
