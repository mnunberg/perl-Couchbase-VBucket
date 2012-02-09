#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Couchbase::VBucket;
use Data::Dumper;


my $data = join("", <DATA>);
my $vb = Couchbase::VBucket->parse($data);
isa_ok($vb, "Couchbase::VBucket");
my $server = $vb->map("foobar");
is($server, "172.16.16.76:12000", "Got expected server for mapping");
my @actx = $vb->map("barbaz");

is($actx[0], "172.16.16.76:12004", "Got right server in array context");
is($actx[1], 2, "got right index in array context");

my $servers = $vb->servers();

@$servers = sort @$servers;
my $expected_servers = [
          '172.16.16.76:12014',
          '172.16.16.76:12010',
          '172.16.16.76:12012',
          '172.16.16.76:12000',
          '172.16.16.76:12008',
          '172.16.16.76:12004',
          '172.16.16.76:12002',
          '172.16.16.76:12006'
        ];
@$expected_servers = sort @$expected_servers;

is_deeply($expected_servers, $servers, "Got server list");

done_testing();

__DATA__

{
  "name": "default",
  "bucketType": "memcached",
  "authType": "sasl",
  "saslPassword": "",
  "proxyPort": 0,
  "uri": "/pools/default/buckets/default",
  "streamingUri": "/pools/default/bucketsStreaming/default",
  "flushCacheUri": "/pools/default/buckets/default/controller/doFlush",
  "nodes": [
    {
      "systemStats": {
        "cpu_utilization_rate": 9.925558312655086,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10837",
      "memoryTotal": 8308625408,
      "memoryFree": 397672448,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9507/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9007",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12015,
        "direct": 12014
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 7.5,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10837",
      "memoryTotal": 8308625408,
      "memoryFree": 397672448,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9505/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9005",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12011,
        "direct": 12010
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 6.015037593984962,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10836",
      "memoryTotal": 8308625408,
      "memoryFree": 395079680,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9506/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9006",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12013,
        "direct": 12012
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 9.701492537313433,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10838",
      "memoryTotal": 8308625408,
      "memoryFree": 394182656,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9500/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "thisNode": true,
      "hostname": "172.16.16.76:9000",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12001,
        "direct": 12000
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 7.94044665012407,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10836",
      "memoryTotal": 8308625408,
      "memoryFree": 395079680,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9504/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9004",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12009,
        "direct": 12008
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 9.925558312655086,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10837",
      "memoryTotal": 8308625408,
      "memoryFree": 394817536,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9502/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9002",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12005,
        "direct": 12004
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 9.022556390977444,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10837",
      "memoryTotal": 8308625408,
      "memoryFree": 395333632,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9501/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9001",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12003,
        "direct": 12002
      }
    },
    {
      "systemStats": {
        "cpu_utilization_rate": 6.015037593984962,
        "swap_total": 7999582208,
        "swap_used": 63811584
      },
      "interestingStats": {
        "curr_items": 0,
        "curr_items_tot": 0,
        "vb_replica_curr_items": 0
      },
      "uptime": "10836",
      "memoryTotal": 8308625408,
      "memoryFree": 395079680,
      "mcdMemoryReserved": 6338,
      "mcdMemoryAllocated": 6338,
      "couchApiBase": "http://172.16.16.76:9503/default",
      "replication": 1.0,
      "clusterMembership": "active",
      "status": "healthy",
      "hostname": "172.16.16.76:9003",
      "clusterCompatibility": 1,
      "version": "1.7.1_424_g209e7bf",
      "os": "x86_64-pc-linux-gnu",
      "ports": {
        "proxy": 12007,
        "direct": 12006
      }
    }
  ],
  "stats": {
    "uri": "/pools/default/buckets/default/stats",
    "directoryURI": "/pools/default/buckets/default/statsDirectory",
    "nodeStatsListURI": "/pools/default/buckets/default/nodes"
  },
  "nodeLocator": "ketama",
  "autoCompactionSettings": false,
  "replicaNumber": 0,
  "quota": {
    "ram": 2516582400,
    "rawRAM": 314572800
  },
  "basicStats": {
    "quotaPercentUsed": 0.0,
    "opsPerSec": 0,
    "hitRatio": 0,
    "itemCount": 0,
    "diskUsed": 0,
    "memUsed": 0
  },
  "bucketCapabilitiesVer": "sync-1.0",
  "bucketCapabilities": [

  ]
}
