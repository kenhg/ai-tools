#!/usr/bin/env bash
# Claude Code statusLine command

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build model + effort segment
if [ -n "$effort" ]; then
  model_part="$model [$effort]"
else
  model_part="$model"
fi

# Build context progress bar
bar=""
if [ -n "$used_pct" ] && [ "$total_tokens" -gt 0 ]; then
  pct=$(printf "%.0f" "$used_pct")
  bar_len=20
  filled=$(( pct * bar_len / 100 ))
  empty=$(( bar_len - filled ))
  bar_filled=$(printf '%0.s█' $(seq 1 $filled 2>/dev/null) 2>/dev/null || printf '%.0s#' $(seq 1 $filled))
  bar_empty=$(printf '%0.s░' $(seq 1 $empty 2>/dev/null) 2>/dev/null || printf '%.0s-' $(seq 1 $empty))
  # Format token counts in K for readability
  if [ "$total_tokens" -ge 1000 ]; then
    used_k=$(awk "BEGIN { printf \"%.1f\", $used_tokens / 1000 }")
    total_k=$(awk "BEGIN { printf \"%.0f\", $total_tokens / 1000 }")
    token_str="${used_k}k/${total_k}k tokens"
  else
    token_str="${used_tokens}/${total_tokens} tokens"
  fi
  context_part="[${bar_filled}${bar_empty}] ${pct}% ${token_str}"
else
  context_part="context: n/a"
fi

printf "%s | %s\n" "$model_part" "$context_part"
