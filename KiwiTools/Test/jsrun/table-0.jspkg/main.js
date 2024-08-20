"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    console.print("**** table-0.jspkg\n");
    let table = Table("table_1");
    if (table == null) {
        console.print("table load ... failed\n");
        return 1;
    }
    let result = true;
    let fnames = table.fieldNames();
    for (let fname of fnames) {
        console.print("field: " + fname + "\n");
    }
    let cnt = table.recordCount;
    console.print("record count: " + cnt + "\n");
    for (let i = 0; i < cnt; i++) {
        console.print("index = " + i + "\n");
        let rec = table.record(i);
        if (rec != null) {
            console.print(" - record.field1 = "
                + rec.field1 + "\n");
            console.print(" - record.field2 = "
                + rec.field2 + "\n");
        }
        else {
            console.print(" - record: <none>\n");
        }
    }
    if (table.select("a", "field2")) {
        let currec = table.current;
        if (currec != null) {
            console.print("field2 = " + currec.field2 + "\n");
            result = true;
        }
        else {
            console.print("select - null\n");
            result = false;
        }
    }
    else {
        console.print("select - failed\n");
        result = false;
    }
    if (result) {
        console.print("summary: OK\n");
    }
    else {
        console.print("summary: Error\n");
    }
    return 0;
}
