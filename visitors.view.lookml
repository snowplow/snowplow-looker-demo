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

- view: visitors
  sql_table_name: derived.visitors
  fields:
  
  # DIMENSIONS #
  
  # Visitor identifier
  
  - dimension: visitor_id
    sql: ${TABLE}.domain_userid
    hidden: true # Used for counting
  
  # Engagement
  
  - dimension: time_engaged
    type: int
    sql: ${TABLE}.time_engaged_in_seconds
    hidden: true
  
  - dimension: timestamp
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.first_touch_tstamp
  
  # Segment
  
  - dimension: segment
    sql_case:
      Looking for Snowplow details: ${TABLE}.segment = 'Looking for Snowplow details'
      Looking for Snowplow documentation: ${TABLE}.segment = 'Looking for Snowplow documentation'
      Looking for something else: ${TABLE}.segment = 'Looking for something else'
  
  # Event stream
  
  - dimension: event_stream # Links to all events of visitor
    sql: ${visitor_id}
    html: |
      <a href=events?fields=events.event_detail*&f[events.session_id]={{value}}>Event Stream</a>
  
  # MEASURES #
  
  - measure: total_visitors
    type: count_distinct
    sql: ${visitor_id}
    drill_fields:
      - visitor_id
      - event_stream

  - measure: total_time_engaged
    type: sum
    sql: ${time_engaged}
  
  - measure: total_time_engaged_in_hours
    type: sum
    sql: ${time_engaged}/3600
  
  - measure: time_engaged_per_visitor
    type: number
    decimals: 0
    sql: ${total_time_engaged}/NULLIF(${total_visitors}, 0)::REAL
    value_format: '#,##0"s"'
