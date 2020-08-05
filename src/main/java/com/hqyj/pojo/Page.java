package com.hqyj.pojo;

public class Page {
private int Page = 1;
private int Row = 4;

    public Page() {
    }

    public Page(int page, int row) {
        Page = page;
        Row = row;
    }

    public int getPage() {
        return Page;
    }

    public void setPage(int page) {
        Page = page;
    }

    public int getRow() {
        return Row;
    }

    public void setRow(int row) {
        Row = row;
    }
}