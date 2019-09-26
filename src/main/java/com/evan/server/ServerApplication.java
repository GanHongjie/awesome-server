package com.evan.server;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author geoffrey
 */
// 允许SpringBoot应用开启Swagger2
// 访问http://localhost:8081/swagger-ui.html即可查看接口信息
@EnableSwagger2
@SpringBootApplication
@MapperScan("com.evan.server.mapper")
public class ServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(ServerApplication.class, args);
    }

}
