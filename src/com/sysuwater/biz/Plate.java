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
	
	/**
	 * ������
	 */
	private String introduction;
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

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
	 * ��ȡ���а��
	 * @return
	 */
	public Plate[] getPlateList(){
		Plate[] plates = new Plate[2];
		return plates;
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
