package com.evan.server.config;

import com.evan.server.service.BbsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.DigestUtils;

import java.io.PrintWriter;

/**
 * @author EvanGan
 */
@EnableWebSecurity
public class WebSecureConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    BbsUserService userService;
    @Autowired
    AuthenticationAccessDeniedHandler handler;

//    @Override
//    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//
//        auth.userDetailsService(userService).passwordEncoder(new PasswordEncoder() {
//            @Override
//            public String encode(CharSequence charSequence) {
//                return DigestUtils.md5DigestAsHex(charSequence.toString().getBytes());
//            }
//
//            @Override
//            public boolean matches(CharSequence charSequence, String s) {
//                return s.equals(DigestUtils.md5DigestAsHex(charSequence.toString().getBytes()));
//            }
//        });
//    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // TODO: 2019/9/26 配置权限
//        http.authorizeRequests();
//        http.authorizeRequests()
//                .antMatchers("/admin/category/all").authenticated()
//                .antMatchers("/admin/**", "/reg").hasRole("超级管理员")
//                .anyRequest().authenticated()//其他的路径都是登录后即可访问
//                .and().formLogin().loginPage("/login_page").successHandler((httpServletRequest, httpServletResponse, authentication) -> {
//            httpServletResponse.setContentType("application/json;charset=utf-8");
//            PrintWriter out = httpServletResponse.getWriter();
//            out.write("{\"status\":\"success\",\"msg\":\"登录成功\"}");
//            out.flush();
//            out.close();
//        })
//                .failureHandler((httpServletRequest, httpServletResponse, e) -> {
//                    httpServletResponse.setContentType("application/json;charset=utf-8");
//                    PrintWriter out = httpServletResponse.getWriter();
//                    out.write("{\"status\":\"error\",\"msg\":\"登录失败\"}");
//                    out.flush();
//                    out.close();
//                }).loginProcessingUrl("/login")
//                .usernameParameter("username").passwordParameter("password").permitAll()
//                .and().logout().permitAll().and().csrf().disable().exceptionHandling().accessDeniedHandler(handler);
    http.authorizeRequests().anyRequest().permitAll().and().logout().permitAll();
    }

}


