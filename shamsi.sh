#!/bin/bash

function gregorian_to_jalali_year {
    local g_year=$1
    ((jalali_year = g_year - 621))
    echo "$jalali_year"
}

function gregorian_to_jalali {
    local g_year=$1
    local g_month=$2
    local g_day=$3

    local jalali_year
    local leap_days
    local g_days_in_year
    local jalali_days_in_year
    local jalali_month
    local jalali_day

    jalali_year=$(gregorian_to_jalali_year "$g_year")

    ((leap_days = (jalali_year - 1) / 33 * 8 + ((jalali_year - 1) % 33 + 3) / 4))
    ((g_days_in_year = (g_year - 1) * 365 + (g_year - 1) / 4 - leap_days))
    ((jalali_days_in_year = g_days_in_year - 226899))

    if ((jalali_days_in_year > 0)); then
        ((jalali_month = (jalali_days_in_year - 1) / 30 + 1))
        ((jalali_day = jalali_days_in_year - (jalali_month - 1) * 30))
    else
        ((jalali_month = (jalali_days_in_year + 365) / 30 + 9))
        ((jalali_day = jalali_days_in_year + 365 - (jalali_month - 10) * 30))
    fi

    echo "$jalali_year/$jalali_month/$jalali_day"
}

current_gregorian_date=$(date +"%Y-%m-%d")
g_year=$(date +"%Y")
g_month=$(date +"%m")
g_day=$(date +"%d")

jalali_date=$(gregorian_to_jalali "$g_year" "$g_month" "$g_day")
echo "Gregorian Date: $current_gregorian_date"
echo "Jalali Date: $jalali_date"
