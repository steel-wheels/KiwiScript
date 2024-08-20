"use strict";
/**
 * @file Language.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
function nameOfLanguage(lang) {
    let result;
    switch (lang) {
        case Language.chinese:
            result = "chinese";
            break;
        case Language.deutch:
            result = "deutch";
            break;
        case Language.english:
            result = "english";
            break;
        case Language.french:
            result = "french";
            break;
        case Language.italian:
            result = "italian";
            break;
        case Language.japanese:
            result = "japanese";
            break;
        case Language.korean:
            result = "korean";
            break;
        case Language.russian:
            result = "russian";
            break;
        case Language.spanish:
            result = "spanish";
            break;
        case Language.others:
            result = "others";
            break;
    }
    return result;
}
function codeOfLanguage(lang) {
    let result;
    switch (lang) {
        case Language.chinese:
            result = "zh-CN";
            break;
        case Language.deutch:
            result = "de";
            break;
        case Language.english:
            result = "en";
            break;
        case Language.french:
            result = "fr";
            break;
        case Language.italian:
            result = "it";
            break;
        case Language.japanese:
            result = "ja";
            break;
        case Language.korean:
            result = "ko";
            break;
        case Language.russian:
            result = "ru";
            break;
        case Language.spanish:
            result = "es";
            break;
        case Language.others:
            result = "?";
            break;
    }
    return result;
}
const allLanguages = [
    Language.chinese,
    Language.deutch,
    Language.english,
    Language.french,
    Language.italian,
    Language.japanese,
    Language.korean,
    Language.russian,
    Language.spanish,
    Language.others
];
