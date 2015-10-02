package com.hw1.blog;

import java.io.IOException;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException {
	SendEmail sender = new SendEmail();
	try {
		_logger.info("Cron Job has been executed");
		String to = "ericmaras@gmail.com";
		String[] addresses = {to};
		sender.send(addresses);
		//Put your logic here
		//BEGIN
		//END
	}
	catch (Exception ex) {
		//Log any exceptions in your Cron Job
	}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doGet(req, resp);
	}
}
