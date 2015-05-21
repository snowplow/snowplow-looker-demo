# Copyright (c) 2013-2015 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
#
# Authors: Christophe Bogaert
# Copyright: Copyright (c) 2013-2015 Snowplow Analytics Ltd
# License: Apache License Version 2.0
#
# Data Model: Demo
# Version: 1.0.0

- view: visits
  sql_table_name: derived.visits
  fields:
  
  # DIMENSIONS #
  
  # Visiter identifier
  
  - dimension: visitor_id
    sql: ${TABLE}.domain_userid
  
  # Visit identifiers (custom server-side sessionization)
  
  - dimension: visit_index
    type: int
    sql: ${TABLE}.visit_index
  
  # TEMPORARY
  
  - dimension: page_path
    sql: ${TABLE}.page_urlpath
  
  - dimension: converted
    type: yesno
    sql: ${TABLE}.other_count > 0
  
  - dimension: returning
    type: yesno
    sql: ${TABLE}.visit_index > 1
  
  - dimension: blogpost
    type: yesno
    sql: ${TABLE}.blogpost
  
  - dimension: first_touch
    type: time
    timeframes: [time, hour, date, week, month, day_of_week]
    sql: ${TABLE}.first_touch_tstamp
  
  - dimension: path
    sql: ${TABLE}.path
  
  # temp measures
  
  - measure: count
    type: count
  
  - measure: percent_of_total
    type: percent_of_total
    sql: ${count}
  
  - measure: blogpost_count
    type: count
    filter:
      blogpost: yes
    
  - measure: returning_count
    type: count
    filter:
      blogpost: yes
      returning: yes
  
  - measure: converted_count
    type: count
    filter:
      converted: yes
  
  - measure: conversion_rate
    type: number
    decimals: 2
    sql: ${converted_count}/NULLIF(${count},0)::REAL
  
  - measure: blogpost_rate
    type: number
    decimals: 0
    sql: 100*${blogpost_count}/NULLIF(${count},0)::REAL
  
  - measure: returning_rate
    type: number
    decimals: 0
    sql: 100*${returning_count}/NULLIF(${blogpost_count},0)::REAL
  