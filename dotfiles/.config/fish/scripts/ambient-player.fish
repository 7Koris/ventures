#!/usr/bin/env fish

set AUDIO_DIR "$HOME/Music/ambient"
set POLL_INTERVAL 10  # seconds between silence checks
set MPV_PID ""

function pick_random_file
    set files (find $AUDIO_DIR -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" -o -name "*.wav" -o -name "*.m4a" \) 2>/dev/null)
    if test (count $files) -eq 0
        echo "No audio files found in $AUDIO_DIR" >&2
        exit 1
    end
    echo $files[(random 1 (count $files))]
end

function other_audio_playing
    # Check for running Stream/Output/Audio nodes that aren't us
    set our_pid (echo $MPV_PID)
    pw-dump 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
our_pid = '$our_pid'
for node in data:
    if node.get('type') != 'PipeWire:Interface:Node':
        continue
    props = node.get('info', {}).get('props', {})
    if props.get('media.class') != 'Stream/Output/Audio':
        continue
    if node.get('info', {}).get('state') != 'running':
        continue
    # skip ourselves
    pid = str(props.get('application.process.id', ''))
    if pid == our_pid:
        continue
    # skip silent/corked streams
    if str(props.get('pulse.corked', 'false')).lower() == 'true':
        continue
    print('yes')
    sys.exit(0)
sys.exit(1)
"
end

function start_playback
    set file (pick_random_file)
    mpv --no-video --really-quiet "$file" &
    set MPV_PID $last_pid
end

function stop_playback
    if test -n "$MPV_PID"
        kill $MPV_PID 2>/dev/null
        set MPV_PID ""
    end
end

function is_mpv_running
    if test -z "$MPV_PID"
        return 1
    end
    kill -0 $MPV_PID 2>/dev/null
end

# Cleanup on exit
trap stop_playback EXIT INT TERM

while true
    if other_audio_playing
        # Something else is playing — stop our ambient track
        if is_mpv_running
            stop_playback
        end
    else
        # Nothing else playing — ensure we're playing
        if not is_mpv_running
            start_playback
        end
    end
    sleep $POLL_INTERVAL
end