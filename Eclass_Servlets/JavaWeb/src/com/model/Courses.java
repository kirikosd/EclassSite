package com.model;

public class Courses {
	String title,professors_afm,department;
	int courseID,semester;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProfessors_afm() {
		return professors_afm;
	}

	public void setProfessors_afm(String professors_afm) {
		this.professors_afm = professors_afm;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public int getSemester() {
		return semester;
	}

	public void setSemester(int semester) {
		this.semester = semester;
	}
	
	public int getCourseID() {
		return courseID;
	}

	public void setCourseID(int courseID) {
		this.courseID = courseID;
	}
	
    @Override
    public String toString() {
        return "Course [Course ID=" + courseID + ", Title=" + title
                + ", Department=" + department + ", Semester=" + semester
                + ", Professor's AFM=" +professors_afm + "]";
    }
}
