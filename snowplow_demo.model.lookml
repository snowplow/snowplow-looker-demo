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

- connection: snowplow_demo

- scoping: true                  # for backward compatibility
- include: '*.view.lookml'       # include all views
- include: '*.dashboard.lookml'  # include all dashboards

- explore: page_views
  joins: 
  - join: visits
    sql_on: |
      page_views.domain_userid = visits.domain_userid AND page_views.visit_index = visits.visit_index
    relationship: many_to_one
  - join: visitors
    sql_on: |
      page_views.domain_userid = visitors.domain_userid
    relationship: many_to_one

- explore: events

- explore: visits
  joins: 
  - join: visitors
    sql_on: |
      visits.domain_userid = visitors.domain_userid
    relationship: many_to_one

- explore: link_clicks