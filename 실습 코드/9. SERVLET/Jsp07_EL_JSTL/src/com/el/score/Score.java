package com.el.score;

public class Score {
	private String name;
	private int kor;
	private int eng;
	private int math;
	private int sum;
	private double avg;
	private String grade;
	
	public Score() {
		super();
	}

	public Score(String name, int kor, int eng, int math) {
		this.name = name;
		this.kor = kor;
		this.eng = eng;
		this.math = math;
		//이렇게하면 처음시작할때 sum grade avg의 setter를 호출해서 기입하게 만듬.
		setSum();
		setAvg();
		setGrade();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getKor() {
		return kor;
	}

	public void setKor(int kor) {
		this.kor = kor;
	}

	public int getEng() {
		return eng;
	}

	public void setEng(int eng) {
		this.eng = eng;
	}

	public int getMath() {
		return math;
	}

	public void setMath(int math) {
		this.math = math;
	}

	public int getSum() {
		return sum;
	}

	public void setSum() {
		this.sum = kor+eng+math;
	}

	public double getAvg() {
		return avg;
	}

	public void setAvg() {
		this.avg = (double)getSum()/3;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade() {
		switch((int)getAvg()/10) {
			case 10:
			case 9:
				grade="A";
				break;
			case 8:
				grade="B";
				break;
			case 7:
				grade="C";
				break;
			case 6:
				grade="D";
				break;
			case 5:
				grade="F";
				break;
		}
		
	}

	@Override
	public String toString() {
		return "Score [name=" + name + ", kor=" + kor + ", eng=" + eng + ", math=" + math + ", sum=" + sum + ", avg="
				+ avg + ", grade=" + grade + "]";
	}
	
}
