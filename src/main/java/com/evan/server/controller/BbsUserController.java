package com.evan.server.controller;


import com.evan.server.bean.BbsUser;
import com.evan.server.mapper.BbsUserMapper;
import com.evan.server.service.BbsUserService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.models.auth.In;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 用户信息表 前端控制器
 * </p>
 *
 * @author geoffrey
 * @since 2019-09-25
 */
@RestController
public class BbsUserController {
    @Autowired
    private BbsUserService userService;

    @ApiOperation(value = "获取用户信息值  ", notes = "根据获得的id获取")
    @RequestMapping(value = "user/{id}", method = RequestMethod.GET)
    public BbsUser getUser(@PathVariable Integer id) {
        return userService.getById(id);
    }
}

