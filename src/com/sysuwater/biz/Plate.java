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
		plates[0].pid = 1;
		plates[0].pname = "ѧ��̽��";
		plates[0].introduction = "������ѧ����ʧ��԰";
		
		plates[1].pid = 2;
		plates[0].pname = "�������";
		plates[1].introduction = "������";
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
