package com.evan.server;

import com.evan.server.mapper.BbsUserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ServerApplicationTests {
    @Autowired
    BbsUserMapper bbsUserMapper;
    @Test
    public void contextLoads() {
        System.out.println(bbsUserMapper.selectById(1));
    }

}
