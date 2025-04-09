<script lang="ts">
  import { normalizeProps, useMachine } from "@zag-js/svelte";
  import * as zagSwitch from "@zag-js/switch";
  import { onMount } from "svelte";

  const id = $props.id();
  const service = useMachine(zagSwitch.machine, {
    id,
    name: "switch",
  });
  const api = $derived(zagSwitch.connect(service, normalizeProps));

  let timerElement: Element | null;

  onMount(() => {
    timerElement = document.getElementsByClassName("the-timer")[0];
  });

  $effect(() => {
    if (!timerElement) return;
    if (api.checked) {
      timerElement.classList.remove("font-(family-name:--timer-font)");
    } else {
      timerElement.classList.add("font-(family-name:--timer-font)");
    }
  });
</script>

<label {...api.getRootProps()}>
  <span {...api.getLabelProps()}>{"Make it worse"}</span>
  <input {...api.getHiddenInputProps()} />
  <span {...api.getControlProps()}>
    <span {...api.getThumbProps()}></span>
  </span>
</label>

<style>
  [data-scope="switch"][data-part="root"] {
    display: flex;
    align-items: center;
    position: relative;
    line-height: 0;
    width: fit-content;
    --switch-track-diff: calc(
      var(--switch-track-width) - var(--switch-track-height)
    );
    --switch-thumb-x: var(--switch-track-diff);
    --switch-track-width: 2.7rem;
    --switch-track-height: 1.5rem;
  }

  [data-scope="switch"][data-part="control"] {
    display: inline-flex;
    flex-shrink: 0;
    justify-content: flex-start;
    box-sizing: content-box;
    border-radius: 9999px;
    padding: 0.125rem;
    width: var(--switch-track-width);
    height: var(--switch-track-height);
    transition-property:
      background-color, border-color, color, fill, stroke, opacity, box-shadow,
      transform;
    transition-duration: 150ms;
    background: #cbd5e0;

    -webkit-box-pack: start;
  }

  [data-scope="switch"][data-part="control"][data-state="checked"] {
    background: #0770EF;
  }

  [data-scope="switch"][data-part="control"][data-focus] {
    outline: 2px solid #0770EF;
    outline-offset: 2px;
  }

  [data-scope="switch"][data-part="control"][data-disabled] {
    opacity: 0.4;
    cursor: not-allowed;
  }

  [data-scope="switch"][data-part="thumb"] {
    background: #ffffff;
    transition-property: transform;
    transition-duration: 200ms;
    border-radius: inherit;
    width: var(--switch-track-height);
    height: var(--switch-track-height);
    position: relative;
  }

  [data-scope="switch"][data-part="thumb"]::before {
    -webkit-transition: background-color 0.2s ease-in-out;
    transition: background-color 0.2s ease-in-out;
    position: absolute;
    --thumb-size: calc(var(--switch-track-height) + 0.7rem);
    height: var(--thumb-size);
    width: var(--thumb-size);
    background: transparent;
    content: "";
    z-index: 1;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: inherit;
  }

  [data-scope="switch"][data-part="thumb"][data-state="checked"] {
    transform: translateX(var(--switch-thumb-x));
  }

  [data-scope="switch"][data-part="label"] {
    user-select: none;
    margin-inline-end: 0.5rem;
  }
</style>
