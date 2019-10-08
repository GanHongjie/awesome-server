package com.evan.server.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author geoffrey
 */
@RestController
public class HelloController {
    @RequestMapping(value = "/hello/1",method = RequestMethod.GET)
    public String hello () {
        return "hello world";
    }
}
