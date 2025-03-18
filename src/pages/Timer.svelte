<script lang="ts">
  import { normalizeProps, useMachine } from "@zag-js/svelte";
  import * as timer from "@zag-js/timer";

  const id = $props.id();
  const service = useMachine(timer.machine, {
    id,
    countdown: true,
    autoStart: true,
    startMs: timer.parse({ days: 2, seconds: 10 }),
    onComplete() {
      console.log("Timer completed");
    },
  });
  const api = $derived(timer.connect(service, normalizeProps));
</script>

<div
  {...api.getRootProps()}
  class="inline-flex items-center gap-1 text-xl sm:text-4xl md:text-6xl lg:text-8xl"
>
  <div {...api.getItemProps({ type: "days" })}>
    {api.formattedTime.days}
  </div>
  <div {...api.getSeparatorProps()}>:</div>
  <div {...api.getItemProps({ type: "hours" })}>
    {api.formattedTime.hours}
  </div>
  <div {...api.getSeparatorProps()}>:</div>
  <div {...api.getItemProps({ type: "minutes" })}>
    {api.formattedTime.minutes}
  </div>
  <div {...api.getSeparatorProps()}>:</div>
  <div {...api.getItemProps({ type: "seconds" })}>
    {api.formattedTime.seconds}
  </div>
</div>
