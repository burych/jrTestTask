package com.burych.jrtesttask.controller;

import com.burych.jrtesttask.model.User;
import com.burych.jrtesttask.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class UserController {
    private UserService userService;
    String srhString = "";

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }



    @RequestMapping(value="/users")
    public ModelAndView listOfUsers(@RequestParam(required = false) Integer page) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("users");

        modelAndView.addObject("user", new User());
        modelAndView.addObject("searchString", srhString);

        List<User> usersList = userService.listUsers(srhString);

        PagedListHolder<User> pagedListHolder = new PagedListHolder<User>(usersList);
        pagedListHolder.setPageSize(5);

        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if(page==null || page < 1 || page > pagedListHolder.getPageCount()){page=1;}

        modelAndView.addObject("page", page);

        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            modelAndView.addObject("listUsers", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            modelAndView.addObject("listUsers", pagedListHolder.getPageList());
        }
        return modelAndView;
    }


    @RequestMapping(value = "/users/search")
    public ModelAndView Search(@RequestParam("searchString") String searchString, @RequestParam(required = false) Integer page) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("users");

        modelAndView.addObject("user", new User());
        srhString = searchString;
        modelAndView.addObject("searchString", searchString);

        List<User> usersList = userService.listUsers(searchString);

        PagedListHolder<User> pagedListHolder = new PagedListHolder<User>(usersList);
        pagedListHolder.setPageSize(5);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if(page==null || page < 1 || page > pagedListHolder.getPageCount()){page=1;}

        modelAndView.addObject("page", page);
        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            modelAndView.addObject("listUsers", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            modelAndView.addObject("listUsers", pagedListHolder.getPageList());
        }
        return modelAndView;
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
        if(user.getId() == 0){
            this.userService.addUser(user);
        }else {
            this.userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);
        return "redirect:/users";
    }

    @RequestMapping("/edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));
        //model.addAttribute("listUsers", this.userService.listUsers(srhString));
        return "users";
    }

    @RequestMapping("userdata/{id}")
    public String userData(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));
        return "userdata";
    }
}
