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

- view: link_clicks
  sql_table_name: derived.link_clicks
  fields:
  
  # DIMENSIONS #
  
  - dimension: visitor_id
    sql: ${TABLE}.domain_userid
    hidden: true # Used for counting
  
  - dimension: timestamp
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.collector_tstamp
  
  - dimension: target_host
    sql: ${TABLE}.link_target_url_host
  
  - dimension: internal
    type: yesno
    sql: ${TABLE}.link_target_is_internal_click
  
  - dimension: github_snowplow
    type: yesno
    sql: ${TABLE}.link_target_is_github_snowplow
  
  - measure: count
    type: count