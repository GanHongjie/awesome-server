package com.evan.server.config;

import com.evan.server.service.BbsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    @Value("${swagger.isSwaggerEnable}")
    private boolean isSwaggerEnable;

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
        // 所有role都可以访问的路径
        String[] whiteList = {"/introduction/**", "/team/**", "/teachContent/**", "/teachMethod/**", "/teachCondition/**", "/teachEffect/**", "/hello/*", "/user/*"};
        // 在开发环境中，开启swagger接口
        if (isSwaggerEnable) {
            http.authorizeRequests()
                    // 白名单中的接口都能访问
                    .antMatchers(whiteList).permitAll()

                    .antMatchers("/swagger-ui.html").permitAll()
                    .antMatchers("/swagger-resources/**").permitAll()
                    .antMatchers("/images/**").permitAll()
                    .antMatchers("/webjars/**").permitAll()
                    .antMatchers("/v2/api-docs").permitAll()
                    .antMatchers("/configuration/ui").permitAll()
                    .antMatchers("/configuration/security").permitAll()

                    // 否则需要登入拉去权限
                    .antMatchers("/admin/*").hasRole("admin")
                    .antMatchers("/teacher/**").hasRole("teacher")
                    .antMatchers("/student/**").hasRole("student")
                    .anyRequest().authenticated().and()
                    .csrf().disable()
                    // 允许跨域
                    .cors();
        } else {
            http.authorizeRequests()
                    // 白名单中的接口都能访问
                    .antMatchers(whiteList).permitAll()
                    // 否则需要登入拉去权限
                    .antMatchers("/admin/*").hasRole("admin")
                    .antMatchers("/teacher/**").hasRole("teacher")
                    .antMatchers("/student/**").hasRole("student")
                    .anyRequest().authenticated().and()
                    .csrf().disable()
                    // 允许跨域
                    .cors();
        }
    }

}


