# nushell themes

# Colors 
# signal colors:
    # shape_operator: { fg: "#fb7b42" }
    # shape_int: { fg: "#b93344" }
    # shape_float: { fg: "#b93344" }
	# https://www.schemecolor.com/apache-server-logo-colors.php
# ocean theme: 
	# https://www.schemecolor.com/ocean-gradient.php
	# https://www.schemecolor.com/endless-sea.php

export-env {
    let-env ocean_theme = {
        # color for nushell primitives
        separator: dark_gray
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: { fg: "#48BF92" }
        empty: white
        bool: { fg: "#a22160" }
        # bool: { fg: "#4B8DA0" }
        int: { fg: "#b93344" }
        # int: { fg: "#4B8DA0" }
        filesize: { fg: "#4C74A6" }
        duration: { fg: "#4C74A6" }
        date: { fg: "#4E5BAD" }
        range: { fg: "#b93344" }
        # range: { fg: "#4B8DA0" }
        float: { fg: "#b93344" }
        # float: { fg: "#4B8DA0" }
        string: { fg: "#49A699" }
        # string: { fg: "#497a82" }
        nothing: white
        binary: { fg: "#9c1027" }
        # binary: dark_gray
        cellpath: dark_gray
        row_index: { fg: "#48BF92" }
        record: { fg: "#06a595" }
        list: { fg: "#06a595" }
        block: { fg: "#06a595" }
        hints: dark_gray

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: { fg: "#9c1027" }
        shape_bool: { fg: "#a22160" }
        shape_int: { fg: "#b93344" }
        shape_float: { fg: "#b93344" }
        shape_range: { fg: "#731f46" }
        shape_internalcall: { fg: "#2952ac" attr: b }
        shape_external: { fg: "#194775" attr: b }
        shape_externalarg: { fg: "#6684a3" }
        shape_literal: { fg: "#1692c4" }
        shape_operator: { fg: "#731f46" }
        shape_signature: { fg: "#1692c4" }
    	shape_string : { fg: "#007089" }
        shape_string_interpolation: { fg: "#1692c4" }
        shape_datetime: { fg: "#8F670B" }
        shape_list: { fg: "#06a595" }
        shape_table: { fg: "#06a595" }
        shape_record: { fg: "#06a595" }
        shape_block: { fg: "#06a595" }
        shape_filepath: { fg: "#1692c4" }
        shape_globpattern: { fg: "#1692c4" }
        shape_variable: { fg: "#236fc5" }
        shape_flag: { fg: "#137087" }
        shape_custom: { fg: "#1692c4" }
        shape_nothing: white
    }

    # minimal theme
    let steel1      = "#5E6C85"
    let steel2      = "#6F7D95"
    let steel3      = "#808EA5"
    let steel4      = "#909FB6"
    let steel5      = "#A1B0C6"
    let steel6      = "#B2C1D6"
    let rred        = "#d32c5d"
    let lred        = "#dc597f"
    let dgrey       = "#565B61" 
    let violetred   = "#8b2252"

    let-env minimal_theme = {
        # color for nushell primitives
        separator: dgrey
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: { fg: $violetred}
        empty: steel6
        bool: { fg: $steel4 }
        int: { fg: $steel5 }
        filesize: { fg: $steel5 }
        duration: { fg: $steel5 }
        date: { fg: $steel5 }
        range: { fg: $steel5 }
        float: { fg: $steel5 }
        string: { fg: $steel6 }
        nothing: steel6
        binary: { fg: $steel5 }
        cellpath: dgrey
        row_index: { fg: $steel1 }
        record: { fg: $steel3 }
        list: { fg: $steel3 }
        block: { fg: $steel3 }
        hints: dgrey

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: { fg: $steel5 }
        shape_bool: { fg: $steel4 }
        shape_int: { fg: $steel5 }
        shape_float: { fg: $steel5 }
        shape_range: { fg: $steel5 }
        shape_internalcall: { fg: $rred attr: b }
        shape_external: { fg: $lred attr: b }
        shape_externalarg: { fg: $steel4 }
        shape_literal: { fg: $steel4 }
        shape_operator: { fg: $steel6 }
        shape_signature: { fg: $steel6 }
    	shape_string : { fg: $steel6 }
        shape_string_interpolation: { fg: $steel6 }
        shape_datetime: { fg: $steel5 }
        shape_list: { fg: $steel3 }
        shape_table: { fg: $steel3 }
        shape_record: { fg: $steel3 }
        shape_block: { fg: $steel3 }
        shape_filepath: { fg: $steel3 }
        shape_globpattern: { fg: $steel4 }
        shape_variable: { fg: $steel2 }
        shape_flag: { fg: $steel1 }
        shape_custom: { fg: $rred }
        shape_nothing: white
    }

    # gruberdarker
    # Colors with _x are lighter. Colors with __x are darker.
    let gruber_darker_fg        = "#e4e4ef"
    let gruber_darker_fg__1      = "#f4f4ff"
    let gruber_darker_fg__2      = "#f5f5f5"
    let gruber_darker_white     = "#ffffff"
    let gruber_darker_black     = "#000000"
    let gruber_darker_bg_1      = "#101010"
    let gruber_darker_bg        = "#181818"
    let gruber_darker_bg__1      = "#282828"
    let gruber_darker_bg__2      = "#453d41"
    let gruber_darker_bg__3      = "#484848"
    let gruber_darker_bg__4      = "#52494e"
    let gruber_darker_red_1     = "#c73c3f"
    let gruber_darker_red       = "#f43841"
    let gruber_darker_red__1     = "#ff4f58"
    let gruber_darker_green     = "#73c936"
    let gruber_darker_yellow    = "#ffdd33"
    let gruber_darker_brown     = "#cc8c3c"
    let gruber_darker_quartz    = "#95a99f"
    let gruber_darker_niagara_2 = "#303540"
    let gruber_darker_niagara_1 = "#565f73"
    let gruber_darker_niagara   = "#96a6c8"
    let gruber_darker_wisteria  = "#9e95c7"

    let-env gruberdarker = {
        # color for nushell primitives
        separator: $gruber_darker_quartz
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: { fg: $gruber_darker_red}
        empty: { fg: $gruber_darker_fg}
        bool: { fg: $gruber_darker_yellow}
        int: { fg: $gruber_darker_quartz}
        filesize: { fg: $gruber_darker_quartz}
        duration: { fg: $gruber_darker_quartz}
        date: { fg: $gruber_darker_niagara_1}
        range: { fg: $gruber_darker_quartz}
        float: { fg: $gruber_darker_quartz}
        string: { fg: $gruber_darker_fg}
        nothing: { fg: $gruber_darker_fg}
        binary: { fg: $gruber_darker_quartz}
        cellpath: { fg: $gruber_darker_fg}
        row_index: { fg: $gruber_darker_niagara_2}
        record: { fg: $gruber_darker_quartz}
        list: { fg: $gruber_darker_quartz}
        block: { fg: $gruber_darker_quartz}
        hints: { fg: $gruber_darker_quartz}

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: { fg: $gruber_darker_quartz}
        shape_bool: { fg: $gruber_darker_yellow}
        shape_int: { fg: $gruber_darker_quartz}
        shape_float: { fg: $gruber_darker_quartz}
        shape_range: { fg: $gruber_darker_quartz}
        shape_internalcall: { fg: $gruber_darker_yellow attr: b }
        shape_external: { fg: $gruber_darker_yellow }
        shape_externalarg: { fg: $gruber_darker_niagara_1}
        shape_literal: { fg: $gruber_darker_quartz}
        shape_operator: { fg: $gruber_darker_fg}
        shape_signature: { fg: $gruber_darker_fg}
    	shape_string : { fg: $gruber_darker_fg}
        shape_string_interpolation: { fg: $gruber_darker_fg}
        shape_datetime: { fg: $gruber_darker_quartz}
        shape_list: { fg: $gruber_darker_fg}
        shape_table: { fg: $gruber_darker_fg}
        shape_record: { fg: $gruber_darker_fg}
        shape_block: { fg: $gruber_darker_fg}
        shape_filepath: { fg: $gruber_darker_fg}
        shape_globpattern: { fg: $gruber_darker_fg}
        shape_variable: { fg: $gruber_darker_green}
        shape_flag: { fg: $gruber_darker_niagara_1}
        shape_custom: { fg: $gruber_darker_brown}
        shape_nothing: white
    }

    # lavendel
    let t1 = "#0e0e0d"
    let t2 = "#121311"
    let t3 = "#2b3444"
    let t4 = "#61586f"
    let t5 = "#686e73"
    let t6 = "#878480"
    let t7 = "#897dca"
    let t8 = "#7b89a3"
    let t9 = "#bcb6ba"
    let t10 = "#9db2b8"
    let t11 = "#a0c7cf"
    let t12 = "#9aacfe"
    
    # markdown 
    let t13 = "#0affa9"
    let t14 = "#6272a4"
    let t15 = "#d32c5d"
    let t16 = "#dcb659"
    let t17 = "#664864"
    let t18 = "#2E6170"

    let t19 = "#7F53BF"

    let diff_minus = "#ff0900"
    let diff_delta = "#0078bd"
    let diff_plus = "#87a800"
    let diff_delta_moved = "#0048bd"

    let highlight = "#ff2e5f"
    let highlight_two = "#dad7d5"
    let highlight_three = "#ff0900"

    let black = "#000000"

    let selection = "#290019"

    let comment = "#56223F"
    let comment_doc = "#585858"

    let error = "#ff0900"
    let warning = "#ffbf00"
    let display = "#57ff89"
    let info = "#dad7d5"

    let-env lavendel = {
        # color for nushell primitives
        separator: $t3        
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: { fg: $t19 attr: bd }
        empty: { fg: $t4}
        bool: { fg: $t14}
        int: { fg: $t14}
        filesize: { fg: $t14}
        duration: { fg: $t4}
        date: { fg: $t6}
        range: { fg: $t9}
        float: { fg: $t14}
        string: { fg: $t9 }
        nothing: { fg: $t4}
        binary: { fg: $t7}
        cellpath: { fg: $t7}
        row_index: { fg: $t4}
        record: { fg: $t4}
        list: { fg: $t4}
        block: { fg: $t4}
        hints: { fg: $comment attr: i}

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: { fg: $t11}
        shape_bool: { fg: $t14}
        shape_int: { fg: $t14}
        shape_float: { fg: $t14}
        shape_range: { fg: $t9}
        shape_internalcall: { fg: $highlight bg: $selection attr: b }
        shape_external: { fg: $highlight bg: $selection}
        shape_externalarg: { fg: $t4}
        shape_literal: { fg: $t4}
        shape_operator: { fg: $t8}
        shape_signature: { fg: $t9}
    	shape_string : { fg: $t9 attr: i }
        shape_string_interpolation: { fg: $t6}
        shape_datetime: { fg: $t8}
        shape_list: { fg: $t4}
        shape_table: { fg: $t4}
        shape_record: { fg: $t4}
        shape_block: { fg: $t4}
        shape_filepath: { fg: $t7}
        shape_globpattern: { fg: $t7}
        shape_variable: { fg: $t7}
        shape_flag: { fg: $t4}
        shape_custom: { fg: $t4}
        shape_nothing: white
    }
}

