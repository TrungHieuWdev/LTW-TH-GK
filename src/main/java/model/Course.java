package model;

public class Course {
    private int id;
    private String code;
    private String name;
    private int credits;
    private String lecturer;
    private String description;

    public Course() {
    }

    public Course(int id, String code, String name, int credits, String lecturer, String description) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.credits = credits;
        this.lecturer = lecturer;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public String getLecturer() {
        return lecturer;
    }

    public void setLecturer(String lecturer) {
        this.lecturer = lecturer;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
