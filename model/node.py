#!/usr/bin/env python
# coding=utf-8
#
# Copyright 2012 F2E.im
# Do have a faith in what you're doing.
# Make your life a story worth telling.

import time
from lib.query import Query

class NodeModel(Query):
    def __init__(self, db):
        self.db = db
        self.table_name = "node"
        super(NodeModel, self).__init__()

    def get_all_nodes(self):
        return self.select()

    def get_all_nodes_count(self):
        return self.count()

    def get_nodes_by_plane_id(self, plane_id):
        where = "plane_id = %s" % plane_id
        return self.where(where).select()

    def get_node_by_node_slug(self, node_slug):
        where = "slug = '%s'" % node_slug
        return self.where(where).find()

    def get_all_hot_nodes(self):
        where = "tmp.reply_count > 0"
        join = "LEFT JOIN (SELECT node_id, MAX(topic.reply_count) as reply_count FROM topic GROUP BY topic.node_id) tmp ON node.id = tmp.node_id"
        order = "tmp.reply_count DESC"
        return self.where(where).join(join).order(order).limit(16).select()

