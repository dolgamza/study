package kr.co.dw.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConfigurationMgr;

/**
 * File Upload Utility
 * 
 * <pre>
 * 
 * 1. Required
 * 
 *    jre\lib\ext\servlet-api.jar
 *    jre\lib\ext\commons-fileupload-1.2.2.jar
 *    jre\lib\ext\commons-io-2.4.jar
 * 
 * 2. Usage
 * 
 *    (1) Form Page
 *
 *        &lt;form action="UploadProc.jsp" method="post" enctype="multipart/form-data"&gt;
 *        &lt;input type="file" name="file1"/&gt;&lt;br&gt;
 *        &lt;input type="file" name="file2"/&gt;&lt;br&gt;
 *        &lt;input type="file" name="file3"/&gt;&lt;br&gt;
 *        &lt;input type="text" name="param1"/&gt;&lt;br&gt;
 *        &lt;input type="text" name="param2"/&gt;&lt;br&gt;
 *        &lt;input type="text" name="param3"/&gt;&lt;br&gt;
 *        &lt;input type="submit" value="Submit" /&gt;
 * 
 * 
 *    (2) Action Page
 * 
 *        UploadUtil upload = new UploadUtil();
 *        upload.uploadFile(request);
 * 
 *        ArrayList&lt;String&gt;       arrFileList = upload.getUploadedFileList();
 *        ArrayList&lt;Long&gt;         arrFileSize = upload.getUploadedFileSizes();
 *        HashMap&lt;String, String&gt; hmParameter = upload.getParameters();
 *        ArrayList&lt;UploadFieldFileVO&gt; arrFieldFile = upload.getFiledFile();
 * 
 *        for (int i=0; i&lt;arrFileList.size(); i++) {
 *          out.println(arrFileList.get(i) + " (" + arrFileSize.get(i) + ")&lt;br&gt;");
 *        }
 * 
 *        out.println(hmParameter.get("param1")+"&lt;br&gt;");
 *        out.println(hmParameter.get("param2")+"&lt;br&gt;");
 *        out.println(hmParameter.get("param3")+"&lt;br&gt;");
 * 
 *        arrFileList.clear();
 *        arrFileSize.clear();
 *        hmParameter.clear();
 *        arrFieldFile.clear();
 * 
 * </pre>
 * 
 * @author DOLGAMZA
 * @version 1.0
 * @since 2012.08
 *
 */
public class UploadUtil  {

	ArrayList<String>  arrFileNames;
	ArrayList<Long>    arrFileSizes;
	HashMap<String, String> hmParams;
	ArrayList<UploadFieldFileVO> arrFieldFile;
	
	Logger logger = Logger.getLogger(this.getClass());
	String strUploadPath = "";
	
	public UploadUtil() {
		arrFileNames = new ArrayList<String>();
		arrFileSizes = new ArrayList<Long>();
		hmParams     = new HashMap<String, String>();
		arrFieldFile = new ArrayList<UploadFieldFileVO>();
	}
	
	/**
	 * Upload File
	 * 
	 * @param request
	 */
	public void uploadFile(HttpServletRequest request) {
		int intMaxSize = 1024*1024*100;
		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart==true) {
				DiskFileItemFactory factory  = new DiskFileItemFactory();
				factory.setRepository(getUploadTempFilePath());
				factory.setSizeThreshold(intMaxSize);
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setSizeMax(intMaxSize);
				upload.setHeaderEncoding("utf-8");
				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if (item.isFormField() == false) moveUploadedFile(item);
					else setParameter(item);
				}
			}
		} catch (Exception e) {
			logger.error("File Upload is Failure." + e.toString());
		}
	}

	
	/**
	 * Upload File
	 * 
	 * @param request
	 */
	public void uploadFile(HttpServletRequest request, String strEncodeType) {
		int intMaxSize = 1024*1024*100;
		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart==true) {
				DiskFileItemFactory factory  = new DiskFileItemFactory();
				factory.setRepository(getUploadTempFilePath());
				factory.setSizeThreshold(intMaxSize);
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setSizeMax(intMaxSize);
				upload.setHeaderEncoding(strEncodeType);
				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if (item.isFormField() == false) moveUploadedFile(item);
					else setParameter(item, strEncodeType);
				}
			}
		} catch (Exception e) {
			logger.error("File Upload is Failure." + e.toString());
		}
	}
	
	
	/**
	 * Upload File
	 * 
	 * @param request
	 * @param strEncodeType
	 * @param strSubPath
	 * 
	 */
	public void uploadFile(HttpServletRequest request, String strEncodeType, String strSubPath) {
		int intMaxSize = 1024*1024*100;
		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart==true) {
				DiskFileItemFactory factory  = new DiskFileItemFactory();
				factory.setRepository(getUploadTempFilePath());
				factory.setSizeThreshold(intMaxSize);
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setSizeMax(intMaxSize);
				upload.setHeaderEncoding(strEncodeType);
				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if (item.isFormField() == false) moveUploadedFile(item, strSubPath);
					else setParameter(item, strEncodeType);
				}
			}
		} catch (Exception e) {
			logger.error("File Upload is Failure." + e.toString());
		}
	}
	
	
	/**
	 * Set Request Parameters
	 * 
	 * @param item
	 */
	private void setParameter(FileItem item, String strEncodeType) {
		try {
			hmParams.put(item.getFieldName(), StrUtil.nvl(item.getString(strEncodeType)));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Move File From Repository To Upload Directory
	 * 
	 * @param item
	 * @throws Exception
	 */
	private void moveUploadedFile(FileItem item) throws Exception {
		if (item.getSize()>0) {
			String  strFileName    = getFileName(item.getName());
			
			String[] arrFileNm = strFileName.split("_");
			String saveFileNm = arrFileNm[arrFileNm.length-1];
			
			String  strContentType = item.getContentType();
			long    lngByteSize    = item.getSize();
			
			setUploadFiledFile(item, strFileName, lngByteSize);
			System.out.println("FileUpload : " + strFileName + "(" + lngByteSize + "byte, " + strContentType + ")");

			try {
				File uploadedFile = new File(getUploadFilePath(), saveFileNm);		//
				item.write(uploadedFile);
				item.delete();
			} catch (Exception e) {
				System.out.println("File Upload is Failure." + e.toString());
			}
		}

	}

	/**
	 * Move File From Repository To Upload Directory
	 * 
	 * @param item
	 * @param strSubPath
	 * @throws Exception
	 */
	private void moveUploadedFile(FileItem item, String strSubPath) throws Exception {
		if (item.getSize()>0) {
			String  strFileName    = getFileName(item.getName());
			
			String[] arrFileNm = strFileName.split("_");
			String saveFileNm = arrFileNm[arrFileNm.length-1];
			
			String  strContentType = item.getContentType();
			long    lngByteSize    = item.getSize();
			
			setUploadFiledFile(item, strFileName, lngByteSize);
			System.out.println("FileUpload : " + strFileName + "(" + lngByteSize + "byte, " + strContentType + ")");

			try {
				File uploadedFile = new File(getUploadFilePath() + strSubPath, saveFileNm);
				item.write(uploadedFile);
				item.delete();
			} catch (Exception e) {
				System.out.println("File Upload is Failure." + e.toString());
			}
		}
	}
	
	/**
	 * FileName Filter
	 * 
	 * @param str
	 * @return
	 */
	private String getFileName(String str) {
		long time = System.currentTimeMillis ( ); 
		long milsec = (time)%60;
		//System.out.println ("MILLISECOND:::::::::::::::"+(time)%60); 
		
		String strDateTime = DateTimeUtil.getCurrentDate("") + DateTimeUtil.getCurrentTime().replace(":", "") + milsec;
		String slash = "________";

		if(str.lastIndexOf(".") > 0) {
			String filename      = str.substring(0, str.lastIndexOf("."));
			String fileExtension = str.substring(str.lastIndexOf("."), str.length());
			str = filename.replaceAll("\\.", "") + fileExtension;
		}
		
		str = str.replace("/", slash);
		str = str.replace("\\", slash);
		String[] s = str.split(slash);

		String result = "";
		if(str.lastIndexOf(".") > 0) {
			result = s[s.length-1].replace(".", "_" + strDateTime + ".");
		}else {
			result = s[s.length-1] + "_" + strDateTime;
		}
		
		return result;
	}

	
	/**
	 * Set UploadFieldFile
	 * 
	 * @param item
	 * @param strFileName
	 * @param lngByteSize
	 */
	private void setUploadFiledFile(FileItem item, String strFileName, long lngByteSize) {
		UploadFieldFileVO vo = new UploadFieldFileVO();
		vo.FIELD_NM = item.getFieldName();
		vo.FILE_NM  = strFileName;
		vo.FILE_SIZE = lngByteSize;
		arrFieldFile.add(vo);
		
		arrFileNames.add(strFileName);
		arrFileSizes.add(lngByteSize);
	}
	
	
	/**
	 * Set Request Parameters
	 * 
	 * @param item
	 */
	private void setParameter(FileItem item) {
		hmParams.put(item.getFieldName(), StrUtil.nvl(item.getString()));
	}
	
	
	public void setUploadFilePath(String strPath) {
		this.strUploadPath = strPath;
	}
	
	/**
	 * Get Upload File Path From ConfigurationMgr
	 * 
	 * @return upload file path
	 */
	public String getUploadFilePath() {
		String  strPath = (this.strUploadPath==null || this.strUploadPath.equals("")) ? ConfigurationMgr.getInstance().getString("UPLOAD_FILE_PATH") : this.strUploadPath;
		System.out.println("UploadFiles Directory is " + strPath);
		return strPath;
	}

	/**
	 * Get Upload Repository From ConfigurationMgr
	 * 
	 * @return repository
	 */
	private File getUploadTempFilePath() {
		String  strPath = ConfigurationMgr.getInstance().getString("UPLOAD_TEMP_FILE_PATH");
		System.out.println("Repository is " + strPath);
		return new File(strPath);		
	}
	
	/**
	 * Get Uploaded File List
	 * 
	 * @return filename
	 */
	public ArrayList<String> getUploadedFileList() {
		return this.arrFileNames;
	}
	
	/**
	 * Get Uploaded File Sizes
	 * 
	 * @return size(byte)
	 */
	public ArrayList<Long> getUploadedFileSizes() {
		return this.arrFileSizes;
	}

	/**
	 * Get Form Parameters
	 * 
	 * @return request parameters
	 */
	public HashMap<String, String> getParameters() {
		return this.hmParams;
	}
	
	public ArrayList<UploadFieldFileVO> getFiledFile() {
		return this.arrFieldFile;
	}
}



