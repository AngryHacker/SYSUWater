package com.sysuwater.biz;

/**
 * ���
 * @author
 *
 */
public class Plate {
	
	/**
	 * ��� ID
	 */
	private int pid;
	
	/**
	 * �������
	 */
	private String pname;
	
	public int getPid(){
		return pid;
	}
	
	public void setPid(int pid){
		this.pid = pid;
	}
	
	public String getPname(){
		return pname;
	}
	
	public void setPname(String pname){
		this.pname = pname;
	}
	
	/**
	 * �����°�飬��ʱ��д
	 * 
	 * @param pname
	 * @return
	 */
	public boolean createNewPlate(String pname){
		return true;
	}

}
