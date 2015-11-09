package org.hhs;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.logging.Logger;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/upload")

public class UploadCsvServlet extends HttpServlet {

	static Logger log = Logger.getLogger(UploadCsvServlet.class.getName());

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/*
		 * // Create path components to save the file final String path =
		 * request.getParameter("destination"); final Part filePart =
		 * request.getPart("file"); final String fileName =
		 * getFileName(filePart);
		 */

		String path = request.getContextPath();
		String csvFileToRead = request.getRealPath("/") + "mail.csv";
		BufferedReader br = null;
		String line = "";
		String splitBy = ",";

		JSONArray jArrayMails = new JSONArray();
		try {
			br = new BufferedReader(new FileReader(csvFileToRead));
			while ((line = br.readLine()) != null) {
				jArrayMails.add(line);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject jobj = new JSONObject();
		jobj.put("studentEmailsArray", jArrayMails);
		out.print(jobj);

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);

	}
}
