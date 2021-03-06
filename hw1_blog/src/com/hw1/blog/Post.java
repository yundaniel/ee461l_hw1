
package com.hw1.blog;

import java.util.Date;
import java.util.Calendar;
import java.util.TimeZone;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Post implements Comparable<Post> {
    @Id Long id;
    User user;
    String title;
    String content;
    Date date;

    private Post() {}

    public Post(User user, String title, String content) {
        this.user = user;
        this.title = title;
        this.content = content;
        date = Calendar.getInstance(TimeZone.getTimeZone("US/Central")).getTime();;
    }

    public User getUser() {
        return user;
    }

    public Date getDate() {
    	return date;
    }
    
    public String getTitle() {
        return title;
    }
    
    public String getContent() {
    	return content;
    }

    @Override
    public int compareTo(Post other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
    }
}