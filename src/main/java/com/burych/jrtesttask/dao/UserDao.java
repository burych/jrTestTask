package com.burych.jrtesttask.dao;

import com.burych.jrtesttask.model.User;
import java.util.List;

public interface UserDao {
    public void addUser(User user);
    public void updateUser(User user);
    public void removeUser(int id);
    public User getUserById(int id);
    public List<User> listUsers();
    public List<User> listUsers(String str1);

}
