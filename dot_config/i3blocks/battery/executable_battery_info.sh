#!/bin/sh

# If ACPI was not installed, this probably is a battery-less computer.
ACPI_RES=$(acpi -b)
ACPI_CODE=$?
if [ $ACPI_CODE -eq 0 ]
then
    # Get essential information. Due to some bug with some versions of acpi it is
    # worth filtering the ACPI result from all lines containing "unavailable".
    BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
    BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
    TIME_LEFT=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9]{2}:[0-9]{2}:[0-9]{2}")
    IS_CHARGING=$(echo "$ACPI_RES" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')

    # If there is no 'time left' information (when almost fully charged) we
    # provide a fallback.
    if [ -z "$TIME_LEFT" ]
    then
        TIME_LEFT="00:00:00"
    fi

    TIME_LEFT=$(echo $TIME_LEFT | awk '{ printf("%s\n", substr($1, 0, 5)) }')

    # Only show time left if battery is below 100%
    BAT_NUM=${BAT_LEVEL%%%}  # strip %
    if [ "$BAT_NUM" -lt 100 ]; then
        FULL_TEXT=" BAT: $BAT_LEVEL ⏳$TIME_LEFT "
    else
        FULL_TEXT=" BAT: $BAT_LEVEL "
    fi

    echo "$FULL_TEXT"
    echo "BAT: $BAT_LEVEL"

    # Color selection
    if [ "$IS_CHARGING" = "Charging" ]
    then
        # Charging yellow color.
        echo "#D0D000"
    else
        if [ "$BAT_NUM" -le 15 ]
        then
            # Battery very low. Red color.
            echo "#FA1E44"
        else
            # Battery not charging but at decent level. Green color.
            echo "#007872"
        fi
    fi
fi
