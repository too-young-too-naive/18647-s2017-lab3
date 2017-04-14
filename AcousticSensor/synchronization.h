#ifndef _SYNCHRONIZATION_H
#define _SYNCHRONIZATION_H

#include "ADCConfig.h"

#ifndef MASTER_CLOCK
  #define MASTER_CLOCK 1
#endif

#define TIMESTAMP_SIZE    (sizeof(tstamp_t))
#define SYNC_PACKET_SIZE  (TIMESTAMP_SIZE * 1)
#define RESP_PACKET_SIZE  (TIMESTAMP_SIZE * 3)

/* Use this to initialize the tasks related to synchronizing clocks */
void startSyncTasks(int priority);  // set priority of ntp tasks

#endif // _SYNCHRONIZATION_H
