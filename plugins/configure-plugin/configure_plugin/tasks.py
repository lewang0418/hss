########
# Copyright (c) 2014 GigaSpaces Technologies Ltd. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#    * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    * See the License for the specific language governing permissions and
#    * limitations under the License.

from cloudify.decorators import workflow, operation
from cloudify import ctx
import os

@workflow
def config_dns(ctx, endpoint, **kwargs):
    # setting node instance runtime property
    ctx.logger.info('workflow parameter: {0}'.format(endpoint['ip_address']))
    
    nodes = ['hss']
    graph = ctx.graph_mode()
    for node in ctx.nodes:
        ctx.logger.info('In node: {0}'.format(node.id))
        if node.id in nodes:
            ctx.logger.info('In node: {0}'.format(node.id))

            for instance in node.instances:
                sequence = graph.sequence()
                sequence.add(
                    instance.send_event('Starting to run operation'),
                    instance.execute_operation('cloudify.interfaces.lifecycle.configure-dns', \
                        {'dns_ip': endpoint['ip_address']}),
                    instance.send_event('Done running operation')
                )
    return graph.execute()

