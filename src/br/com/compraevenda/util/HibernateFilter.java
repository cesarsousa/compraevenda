package br.com.compraevenda.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.hibernate.Session;

public class HibernateFilter implements Filter {
   
    public HibernateFilter() {}
	
	public void destroy() {}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Session session = CriadorDeSession.getSession();
		request.setAttribute("session", session);		
		chain.doFilter(request, response);
		session.close();		
	}
	
	public void init(FilterConfig fConfig) throws ServletException {}
}
