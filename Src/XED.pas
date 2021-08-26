unit XED;

{$Z4}
{$POINTERMATH ON}

interface
      uses XED.IFormEnum, xed.RegEnum,xed.NonterminalEnum,XED.OperandEnum,xed.OperandTypeEnum,xed.OperandVisibilityEnum,
           xed.OperandElementXtypeEnum,xed.OperandWidthEnum,xed.IClassEnum,xed.CategoryEnum,xed.ExtensionEnum,XED.IsaSetEnum,
           xed.OperandActionEnum,XED.SyntaxEnum,xed.RegClassEnum;

const
  /// @file xed-encoder-gen-defs.h
  XED_ENCODE_ORDER_MAX_ENTRIES    = 32;
  XED_ENCODE_ORDER_MAX_OPERANDS   = 5;
  XED_ENCODE_MAX_FB_PATTERNS      = 121;
  XED_ENCODE_MAX_EMIT_PATTERNS    = 199;
  XED_ENCODE_FB_VALUES_TABLE_SIZE = 3880 ;
  XED_ENCODE_MAX_IFORMS           = 7639;
  XED_ENC_GROUPS                  = 535;

type
  TXEDBool             = Boolean;
  TXEDUnsignedInt8     = UInt8;
  TXEDUnsignedInt16    = UInt16;
  TXEDUnsignedInt32    = UInt32;
  TXEDUnsignedInt64    = UInt64;
  TXEDInt32            = Int32;
  TXEDInt64            = Int64;
  TXEDUnsignedInt8Ptr  = ^TXEDUnsignedInt8;
  TXEDUnsignedInt16Ptr = ^TXEDUnsignedInt16;
  TXEDUnsignedInt32Ptr = ^TXEDUnsignedInt32;
  TXEDUnsignedInt64Ptr = ^TXEDUnsignedInt64;

  xed_uint_t           = Cardinal;
  xed_int_t            = Integer;
  xed_bits_t           = Cardinal;
  xed_bool_t           = Cardinal;

/// @ingroup PRINT
/// A #xed_disassembly_callback_fn_t takes an address, a pointer to a
/// symbol buffer of buffer_length bytes, and a pointer to an offset. The
/// function fills in the symbol_buffer and sets the offset to the desired
/// offset for that symbol.  If the function succeeds, it returns 1.
//  The call back should return 0 if the buffer is not long enough to
//  include the null termination.If no symbolic information is
//  located, the function returns zero.
///  @param address The input address for which we want symbolic name and offset
///  @param symbol_buffer A buffer to hold the symbol name. The callback function should fill this in and terminate
///                       with a null byte.
///  @param buffer_length The maximum length of the symbol_buffer including then null
///  @param offset A pointer to a xed_uint64_t to hold the offset from the provided symbol.
///  @param context This void* pointer passed to the disassembler's new interface so that the caller can identify
///                     the proper context against which to resolve the symbols.
///                     The disassembler passes this value to
///                     the callback. The legacy formatters
///                     that do not have context will pass zero for this parameter.
///  @return 0 on failure, 1 on success.
TXED_Disassembly_Callback_fn = function(address      : TXEDUnsignedInt64;
                                        symbol_buffer: PAnsiChar;
                                        buffer_length: TXEDUnsignedInt32;
                                        offset       : TXEDUnsignedInt64;
                                        context      : pointer): Integer;

  /// @file xed-error-enum.h
  TXEDErrorEnum = (
    XED_ERROR_NONE,                         ///< There was no error
    XED_ERROR_BUFFER_TOO_SHORT,             ///< There were not enough bytes in the given buffer
    XED_ERROR_GENERAL_ERROR,                ///< XED could not decode the given instruction
    XED_ERROR_INVALID_FOR_CHIP,             ///< The instruciton is not valid for the specified chip
    XED_ERROR_BAD_REGISTER,                 ///< XED could not decode the given instruction because an invalid register encoding was used.
    XED_ERROR_BAD_LOCK_PREFIX,              ///< A lock prefix was found where none is allowed.
    XED_ERROR_BAD_REP_PREFIX,               ///< An F2 or F3 prefix was found where none is allowed.
    XED_ERROR_BAD_LEGACY_PREFIX,            ///< A 66, F2 or F3 prefix was found where none is allowed.
    XED_ERROR_BAD_REX_PREFIX,               ///< A REX prefix was found where none is allowed.
    XED_ERROR_BAD_EVEX_UBIT,                ///< An illegal value for the EVEX.U bit was present in the instruction.
    XED_ERROR_BAD_MAP,                      ///< An illegal value for the MAP field was detected in the instruction.
    XED_ERROR_BAD_EVEX_V_PRIME,             ///< EVEX.V'=0 was detected in a non-64b mode instruction.
    XED_ERROR_BAD_EVEX_Z_NO_MASKING,        ///< EVEX.Z!=0 when EVEX.aaa==0
    XED_ERROR_NO_OUTPUT_POINTER,            ///< The output pointer for xed_agen was zero
    XED_ERROR_NO_AGEN_CALL_BACK_REGISTERED, ///< One or both of the callbacks for xed_agen were missing.
    XED_ERROR_BAD_MEMOP_INDEX,              ///< Memop indices must be 0 or 1.
    XED_ERROR_CALLBACK_PROBLEM,             ///< The register or segment callback for xed_agen experienced a problem
    XED_ERROR_GATHER_REGS,                  ///< The index, dest and mask regs for AVX2 gathers must be different.
    XED_ERROR_INSTR_TOO_LONG,               ///< Full decode of instruction would exeed 15B.
    XED_ERROR_INVALID_MODE,                 ///< The instruction was not valid for the specified mode
    XED_ERROR_BAD_EVEX_LL,                  ///< EVEX.LL must not ==3 unless using embedded rounding
    XED_ERROR_BAD_REG_MATCH,                ///< Source registers must not match the destination register for this instruction.
    XED_ERROR_LAST
);
  /// @file xed-machine-mode-enum.h
  TXEDMachineMode = (
    XED_MACHINE_MODE_INVALID,
    XED_MACHINE_MODE_LONG_64,        ///< 64b operating mode
    XED_MACHINE_MODE_LONG_COMPAT_32, ///< 32b protected mode
    XED_MACHINE_MODE_LONG_COMPAT_16, ///< 16b protected mode
    XED_MACHINE_MODE_LEGACY_32,      ///< 32b protected mode
    XED_MACHINE_MODE_LEGACY_16,      ///< 16b protected mode
    XED_MACHINE_MODE_REAL_16,        ///< 16b real mode
    XED_MACHINE_MODE_REAL_32,        ///< 32b real mode (CS.D bit = 1)
    XED_MACHINE_MODE_LAST
);
  /// @file xed-address-width-enum.h
  TXEDAddressWidth = (
    XED_ADDRESS_WIDTH_INVALID=0,
    XED_ADDRESS_WIDTH_16b=2,       ///< 16b addressing
    XED_ADDRESS_WIDTH_32b=4,       ///< 32b addressing
    XED_ADDRESS_WIDTH_64b=8,       ///< 64b addressing
    XED_ADDRESS_WIDTH_LAST
);

  /// @file xed-state.h
  /// Encapsulates machine modes for decoder/encoder requests.
  /// It specifies the machine operating mode as a
  /// #xed_machine_mode_enum_t
  /// for decoding and encoding. The machine mode corresponds to the default
  /// data operand width for that mode. For all modes other than the 64b long
  /// mode (XED_MACHINE_MODE_LONG_64), a default addressing width, and a
  /// stack addressing width must be supplied of type
  /// #xed_address_width_enum_t .  @ingroup INIT
  TXEDStatePtr = ^TXEDState;
  TXEDState = record
      /// real architected machine modes
      mmode: TXEDMachineMode;
      /// for 16b/32b modes
      stack_addr_width: TXEDAddressWidth;
    end;

  /// @file xed-operand-storage.h
  TXEDOperandStoragePtr = ^TXEDOperandStorage;
  TXEDOperandStorage = record
     agen                    : TXEDUnsignedInt8;
     amd3dnow                : TXEDUnsignedInt8;
     asz                     : TXEDUnsignedInt8;
     bcrc                    : TXEDUnsignedInt8;
     cet                     : TXEDUnsignedInt8;
     cldemote                : TXEDUnsignedInt8;
     df32                    : TXEDUnsignedInt8;
     df64                    : TXEDUnsignedInt8;
     dummy                   : TXEDUnsignedInt8;
     encoder_preferred       : TXEDUnsignedInt8;
     encode_force            : TXEDUnsignedInt8;
     has_sib                 : TXEDUnsignedInt8;
     ild_f2                  : TXEDUnsignedInt8;
     ild_f3                  : TXEDUnsignedInt8;
     imm0                    : TXEDUnsignedInt8;
     imm0signed              : TXEDUnsignedInt8;
     imm1                    : TXEDUnsignedInt8;
     lock                    : TXEDUnsignedInt8;
     lzcnt                   : TXEDUnsignedInt8;
     mem0                    : TXEDUnsignedInt8;
     mem1                    : TXEDUnsignedInt8;
     modep5                  : TXEDUnsignedInt8;
     modep55c                : TXEDUnsignedInt8;
     mode_first_prefix       : TXEDUnsignedInt8;
     mode_short_ud0          : TXEDUnsignedInt8;
     mpxmode                 : TXEDUnsignedInt8;
     must_use_evex           : TXEDUnsignedInt8;
     needrex                 : TXEDUnsignedInt8;
     need_sib                : TXEDUnsignedInt8;
     norex                   : TXEDUnsignedInt8;
     no_scale_disp8          : TXEDUnsignedInt8;
     osz                     : TXEDUnsignedInt8;
     out_of_bytes            : TXEDUnsignedInt8;
     p4                      : TXEDUnsignedInt8;
     prefix66                : TXEDUnsignedInt8;
     ptr                     : TXEDUnsignedInt8;
     realmode                : TXEDUnsignedInt8;
     relbr                   : TXEDUnsignedInt8;
     rex                     : TXEDUnsignedInt8;
     rexb                    : TXEDUnsignedInt8;
     rexr                    : TXEDUnsignedInt8;
     rexrr                   : TXEDUnsignedInt8;
     rexw                    : TXEDUnsignedInt8;
     rexx                    : TXEDUnsignedInt8;
     sae                     : TXEDUnsignedInt8;
     tzcnt                   : TXEDUnsignedInt8;
     ubit                    : TXEDUnsignedInt8;
     using_default_segment0  : TXEDUnsignedInt8;
     using_default_segment1  : TXEDUnsignedInt8;
     vexdest3                : TXEDUnsignedInt8;
     vexdest4                : TXEDUnsignedInt8;
     vex_c4                  : TXEDUnsignedInt8;
     wbnoinvd                : TXEDUnsignedInt8;
     zeroing                 : TXEDUnsignedInt8;
     default_seg             : TXEDUnsignedInt8;
     easz                    : TXEDUnsignedInt8;
     eosz                    : TXEDUnsignedInt8;
     first_f2f3              : TXEDUnsignedInt8;
     has_modrm               : TXEDUnsignedInt8;
     last_f2f3               : TXEDUnsignedInt8;
     llrc                    : TXEDUnsignedInt8;
     _mod                    : TXEDUnsignedInt8;
     mode                    : TXEDUnsignedInt8;
     rep                     : TXEDUnsignedInt8;
     sibscale                : TXEDUnsignedInt8;
     smode                   : TXEDUnsignedInt8;
     vex_prefix              : TXEDUnsignedInt8;
     vl                      : TXEDUnsignedInt8;
     hint                    : TXEDUnsignedInt8;
     mask                    : TXEDUnsignedInt8;
     reg                     : TXEDUnsignedInt8;
     rm                      : TXEDUnsignedInt8;
     roundc                  : TXEDUnsignedInt8;
     seg_ovd                 : TXEDUnsignedInt8;
     sibbase                 : TXEDUnsignedInt8;
     sibindex                : TXEDUnsignedInt8;
     srm                     : TXEDUnsignedInt8;
     vexdest210              : TXEDUnsignedInt8;
     vexvalid                : TXEDUnsignedInt8;
     error                   : TXEDUnsignedInt8;
     esrc                    : TXEDUnsignedInt8;
     map                     : TXEDUnsignedInt8;
     nelem                   : TXEDUnsignedInt8;
     scale                   : TXEDUnsignedInt8;
     bcast                   : TXEDUnsignedInt8;
     need_memdisp            : TXEDUnsignedInt8;
     chip                    : TXEDUnsignedInt8;
     brdisp_width            : TXEDUnsignedInt8;
     disp_width              : TXEDUnsignedInt8;
     ild_seg                 : TXEDUnsignedInt8;
     imm1_bytes              : TXEDUnsignedInt8;
     imm_width               : TXEDUnsignedInt8;
     max_bytes               : TXEDUnsignedInt8;
     modrm_byte              : TXEDUnsignedInt8;
     nominal_opcode          : TXEDUnsignedInt8;
     nprefixes               : TXEDUnsignedInt8;
     nrexes                  : TXEDUnsignedInt8;
     nseg_prefixes           : TXEDUnsignedInt8;
     pos_disp                : TXEDUnsignedInt8;
     pos_imm                 : TXEDUnsignedInt8;
     pos_imm1                : TXEDUnsignedInt8;
     pos_modrm               : TXEDUnsignedInt8;
     pos_nominal_opcode      : TXEDUnsignedInt8;
     pos_sib                 : TXEDUnsignedInt8;
     uimm1                   : TXEDUnsignedInt8;
     base0                   : TXEDUnsignedInt16;
     base1                   : TXEDUnsignedInt16;
     element_size            : TXEDUnsignedInt16;
     index                   : TXEDUnsignedInt16;
     outreg                  : TXEDUnsignedInt16;
     reg0                    : TXEDUnsignedInt16;
     reg1                    : TXEDUnsignedInt16;
     reg2                    : TXEDUnsignedInt16;
     reg3                    : TXEDUnsignedInt16;
     reg4                    : TXEDUnsignedInt16;
     reg5                    : TXEDUnsignedInt16;
     reg6                    : TXEDUnsignedInt16;
     reg7                    : TXEDUnsignedInt16;
     reg8                    : TXEDUnsignedInt16;
     reg9                    : TXEDUnsignedInt16;
     seg0                    : TXEDUnsignedInt16;
     seg1                    : TXEDUnsignedInt16;
     iclass                  : TXEDUnsignedInt16;
     mem_width               : TXEDUnsignedInt16;
     disp                    : TXEDUnsignedInt64;
     uimm0                   : TXEDUnsignedInt64;
  end;

  /// @file xed-encoder-iforms.h
  TXEDEncoderIFormsPtr = ^TXEDEncoderIForms;
  TXEDEncoderIForms = record
    x_SIBBASE_ENCODE               : TXEDUnsignedInt32;
    x_SIBBASE_ENCODE_SIB1          : TXEDUnsignedInt32;
    x_SIBINDEX_ENCODE              : TXEDUnsignedInt32;
    x_MODRM_MOD_ENCODE             : TXEDUnsignedInt32;
    x_MODRM_RM_ENCODE              : TXEDUnsignedInt32;
    x_MODRM_RM_ENCODE_EA16_SIB0    : TXEDUnsignedInt32;
    x_MODRM_RM_ENCODE_EA64_SIB0    : TXEDUnsignedInt32;
    x_MODRM_RM_ENCODE_EA32_SIB0    : TXEDUnsignedInt32;
    x_SIB_NT                       : TXEDUnsignedInt32;
    x_DISP_NT                      : TXEDUnsignedInt32;
    x_REMOVE_SEGMENT               : TXEDUnsignedInt32;
    x_REX_PREFIX_ENC               : TXEDUnsignedInt32;
    x_PREFIX_ENC                   : TXEDUnsignedInt32;
    x_VEXED_REX                    : TXEDUnsignedInt32;
    x_XOP_TYPE_ENC                 : TXEDUnsignedInt32;
    x_XOP_MAP_ENC                  : TXEDUnsignedInt32;
    x_XOP_REXXB_ENC                : TXEDUnsignedInt32;
    x_VEX_TYPE_ENC                 : TXEDUnsignedInt32;
    x_VEX_REXR_ENC                 : TXEDUnsignedInt32;
    x_VEX_REXXB_ENC                : TXEDUnsignedInt32;
    x_VEX_MAP_ENC                  : TXEDUnsignedInt32;
    x_VEX_REG_ENC                  : TXEDUnsignedInt32;
    x_VEX_ESCVL_ENC                : TXEDUnsignedInt32;
    x_SE_IMM8                      : TXEDUnsignedInt32;
    x_VSIB_ENC_BASE                : TXEDUnsignedInt32;
    x_VSIB_ENC                     : TXEDUnsignedInt32;
    x_EVEX_62_REXR_ENC             : TXEDUnsignedInt32;
    x_EVEX_REXX_ENC                : TXEDUnsignedInt32;
    x_EVEX_REXB_ENC                : TXEDUnsignedInt32;
    x_EVEX_REXRR_ENC               : TXEDUnsignedInt32;
    x_EVEX_MAP_ENC                 : TXEDUnsignedInt32;
    x_EVEX_REXW_VVVV_ENC           : TXEDUnsignedInt32;
    x_EVEX_UPP_ENC                 : TXEDUnsignedInt32;
    x_AVX512_EVEX_BYTE3_ENC        : TXEDUnsignedInt32;
    x_UIMMv                        : TXEDUnsignedInt32;
    x_SIMMz                        : TXEDUnsignedInt32;
    x_SIMM8                        : TXEDUnsignedInt32;
    x_UIMM8                        : TXEDUnsignedInt32;
    x_UIMM8_1                      : TXEDUnsignedInt32;
    x_UIMM16                       : TXEDUnsignedInt32;
    x_UIMM32                       : TXEDUnsignedInt32;
    x_BRDISP8                      : TXEDUnsignedInt32;
    x_BRDISP32                     : TXEDUnsignedInt32;
    x_BRDISPz                      : TXEDUnsignedInt32;
    x_MEMDISPv                     : TXEDUnsignedInt32;
    x_MEMDISP32                    : TXEDUnsignedInt32;
    x_MEMDISP16                    : TXEDUnsignedInt32;
    x_MEMDISP8                     : TXEDUnsignedInt32;
    x_MEMDISP                      : TXEDUnsignedInt32;
  end;

  /// @file xed-inst.h
  ///

  /// @ingroup DEC
  /// constant information about a decoded instruction form, including
  /// the pointer to the constant operand properties #xed_operand_t for this
  /// instruction form.
  TXEDInstructionPtr = ^TXEDInstruction;
  TXEDInstruction = record
    // rflags info -- index in to the 2 tables of flags information.
    // If _flag_complex is true, then the data are in the
    // xed_flags_complex_table[]. Otherwise, the data are in the
    // xed_flags_simple_table[].
    //xed_instruction_fixed_bit_confirmer_fn_t _confirmer;
    _noperands      : TXEDUnsignedInt8 ;  // number of operands in the operands array
    _cpl            : TXEDUnsignedInt8 ;  // the nominal CPL for the instruction.
    _flag_complex   : TXEDUnsignedInt8 ;  //* 1/0 valued, bool type */
    _exceptions     : TXEDUnsignedInt8 ;  //xed_exception_enum_t
    _flag_info_index: TXEDUnsignedInt16 ;
    _iform_enum     : TXEDUnsignedInt16 ; // xed_iform_enum_t
    _operand_base   : TXEDUnsignedInt16 ; // index into the xed_operand[] array of xed_operand_t structures
    _attributes     : TXEDUnsignedInt16 ; // index to table of xed_attributes_t structures
  end;

  /// @ingroup DEC
  /// Constant information about an individual generic operand, like an
  ///operand template, describing the operand properties. See @ref DEC for
  ///API information.
  TXED_OperandPtr = ^TXED_Operand;
  TXED_Operand = record

      _name  : TXEDUnsignedInt8; // xed_operand_enum_t

      // implicit, explicit, suppressed
      _operand_visibility   : TXEDUnsignedInt8; // xed_operand_visibility_enum_t
      _rw                   : TXEDUnsignedInt8; // read or written // xed_operand_action_enum_t

      // width code, could be invalid (then use register name)
      _oc2                  : TXEDUnsignedInt8; // xed_operand_width_enum_t

      // IMM, IMM_CONST, NT_LOOKUP_FN, REG, ERROR
      _type       : TXEDUnsignedInt8; //xed_operand_type_enum_t
      _xtype      : TXEDUnsignedInt8; // xed data type: u32, f32, etc. //xed_operand_element_xtype_enum_t
      _cvt_idx    : TXEDUnsignedInt8; //  decoration index
      _nt         : TXEDUnsignedInt8;
      u: record
          //* user_data is available as a user data storage field after
          // * decoding. It does not live across re-encodes or re-decodes. */
          case Integer of
          0: (_imm: TXEDUnsignedInt32);
          1: (_nt : TXED_Nonterminal_Enum);
          2: (_reg: TXED_Reg_Enum);
          end;
  end;

  /// @file xed-decoded-inst.h
  ///
  _s = record
     has_modrm : TXEDUnsignedInt8;
     has_disp  : TXEDUnsignedInt8;
     has_imm   : TXEDUnsignedInt8;
  end;

  TXED_ild_vars_t = record
        case Integer of
           0: (i: TXEDUnsignedInt32);
           1: (s: _s);
  end;

  TXEDEncoderVars = record
  end;
  TXEDDencoderVars = record
  end;

  /// @ingroup DEC
  /// The main container for instructions. After decode, it holds an array of
  /// operands with derived information from decode and also valid
  /// #xed_inst_t pointer which describes the operand templates and the
  /// operand order.  See @ref DEC for API documentation.
  TXEDDecodedInstructionPtr = ^TXEDDecodedInstruction;
  TXEDDecodedInstruction = record
    /// The _operands are storage for information discovered during
    /// decoding. They are also used by encode.  The accessors for these
    /// operands all have the form xed3_operand_{get,set}_*(). They should
    /// be considered internal and subject to change over time. It is
    /// preferred that you use xed_decoded_inst_*() or the
    /// xed_operand_values_*() functions when available.
    _operands: TXEDOperandStorage;

    /// Used for encode operand ordering. Not set by decode.
    _operand_order: array[0..XED_ENCODE_ORDER_MAX_OPERANDS-1] of TXEDUnsignedInt8;
    /// Length of the _operand_order[] array.
    _n_operand_order: TXEDUnsignedInt8 ;
    _decoded_length: TXEDUnsignedInt8 ;

    /// when we decode an instruction, we set the _inst and get the
    /// properites of that instruction here. This also points to the
    /// operands template array.
    _inst: TXEDInstructionPtr;

    // decoder does not change it, encoder does
    _byte_array: record
                   case Integer of
                   0: (_enc: TXEDUnsignedInt8Ptr);
                   1: (_dec: TXEDUnsignedInt8Ptr);
                 end;

    // The ev field is stack allocated by xed_encode(). It is per-encode
    // transitory data.
    u: record
          //* user_data is available as a user data storage field after
          // * decoding. It does not live across re-encodes or re-decodes. */
          case Integer of
          0: (user_data: TXEDUnsignedInt64);
          1: (ild_data : TXED_ild_vars_t);
          2: (ev:        TXEDEncoderVars);
          end;
  end;

  /// @file xed-iform-map.h
  ///
  /// @ingroup IFORM
  /// Statically available information about iforms.
  /// Values are returned by #xed_iform_map().
 TXED_iform_infoPtr = ^TXED_iform_info;
  TXED_iform_info = record
    iclass           : TXEDUnsignedInt32; // xed_iclass_enum_t
    category         : TXEDUnsignedInt32; // xed_category_enum_t
    extension        : TXEDUnsignedInt32; // xed_extension_enum_t
    isa_set          : TXEDUnsignedInt32; // xed_isa_set_enum_t
    string_table_idx : TXEDUnsignedInt32; // * if nonzero, index in to the disassembly string table */
end;

 ////////////////////////////////////////////////////////////////////////////
 /// @ingroup FLAGS
 /// a union of flags bits

 _s_ = record
         cf        : TXEDUnsignedInt32; ///< bit 0
         must_be_1 : TXEDUnsignedInt32;
         pf        : TXEDUnsignedInt32;
         must_be_0a: TXEDUnsignedInt32;

         af        : TXEDUnsignedInt32; ///< bit 4
         must_be_0b: TXEDUnsignedInt32;
         zf        : TXEDUnsignedInt32;
         sf        : TXEDUnsignedInt32;

         tf        : TXEDUnsignedInt32;  ///< bit 8
         _if       : TXEDUnsignedInt32;  ///< underscore to avoid token clash
         df        : TXEDUnsignedInt32;
         _of       : TXEDUnsignedInt32;

         iopl      : TXEDUnsignedInt32; ///< A 2-bit field, bits 12-13
         nt        : TXEDUnsignedInt32;
         must_be_0c: TXEDUnsignedInt32;

         rf        : TXEDUnsignedInt32; ///< bit 16
         vm        : TXEDUnsignedInt32;
         ac        : TXEDUnsignedInt32;
         vif       : TXEDUnsignedInt32;

         vip       : TXEDUnsignedInt32; ///< bit 20
         id        : TXEDUnsignedInt32; ///< bit 21
         must_be_0d: TXEDUnsignedInt32; ///< bits 22-23

         must_be_0e: TXEDUnsignedInt32; ///< bits 24-27

         // fc0,fc1,fc2,fc3 are not really part of rflags but I put them
         // here to save space. These bits are only used for x87
         // instructions.
         fc0: TXEDUnsignedInt32;  ///< x87 flag FC0 (not really part of rflags)
         fc1: TXEDUnsignedInt32;  ///< x87 flag FC1 (not really part of rflags)
         fc2: TXEDUnsignedInt32;  ///< x87 flag FC2 (not really part of rflags)
         fc3: TXEDUnsignedInt32;  ///< x87 flag FC3 (not really part of rflags)
 end;

 TXED_Flag_SetPtr = ^TXED_Flag_Set;
 TXED_Flag_Set = record
           case Integer of
                   0: (flat: TXEDUnsignedInt32);
                   1: (s: _s_);
 end;
   

 /// @ingroup FLAGS
 /// A collection of #xed_flag_action_t's and unions of read and written flags
 TXED_Simple_FlagPtr = ^TXED_Simple_Flag;
 TXED_Simple_Flag = record
    ///number of flag actions associated with this record
    nflags     : TXEDUnsignedInt8;

    may_write  : TXEDUnsignedInt8; //* 1/0,  only using one bit */
    must_write : TXEDUnsignedInt8;  //* 1/0,  only using one bit */

    ///union of read flags
    read : TXED_Flag_Set;

    /// union of written flags (includes undefined flags);
    written : TXED_Flag_Set;

    /// union of undefined flags;
    undefined : TXED_Flag_Set;

    // index in to the xed_flag_action_table. nflags limits the # of entries.
    fa_index: TXEDUnsignedInt16;
 end;

  TXEDOperandValues    = TXEDDecodedInstruction ;
  TXEDOperandValuesPtr = TXEDDecodedInstructionPtr ;

 /// @file xed-encode.h
 ///
 TXEDEncoderRequestPtr = ^TXEDEncoderRequest;
 TXEDEncoderRequest = TXEDDecodedInstruction;

/// @file xed-init.h
///
procedure xed_tables_init; cdecl; external 'xed.dll';

/// @file xed-encode.h
///
/// @name Encoding
//@{
///   This is the main interface to the encoder. The array should be
///   at most 15 bytes long. The ilen parameter should indicate
///   this length. If the array is too short, the encoder may fail to
///   encode the request.  Failure is indicated by a return value of
///   type #xed_error_enum_t that is not equal to
///   #XED_ERROR_NONE. Otherwise, #XED_ERROR_NONE is returned and the
///   length of the encoded instruction is returned in olen.
///
/// @param r encoder request description (#xed_encoder_request_t), includes mode info
/// @param array the encoded instruction bytes are stored here
/// @param ilen the input length of array.
/// @param olen the actual  length of array used for encoding
/// @return success/failure as a #xed_error_enum_t
/// @ingroup ENC
function xed_encode(r: TXEDEncoderRequestPtr;
                    arr: TXEDUnsignedInt8Ptr;
                    ilen: UInt32;
                    olen: TXEDUnsignedInt32Ptr): TXEDErrorEnum; cdecl; external 'xed.dll';

/// @file xed-decode.h
///
/// This is the main interface to the decoder.
///  @param xedd the decoded instruction of type #xed_decoded_inst_t . Mode/state sent in via xedd; See the #xed_state_t
///  @param itext the pointer to the array of instruction text bytes
///  @param bytes  the length of the itext input array. 1 to 15 bytes, anything more is ignored.
///  @return #xed_error_enum_t indicating success (#XED_ERROR_NONE) or failure. Note failure can be due to not
///  enough bytes in the input array.
///
/// The maximum instruction is 15B and XED will tell you how long the
/// actual instruction is via an API function call
/// xed_decoded_inst_get_length().  However, it is not always safe or
/// advisable for XED to read 15 bytes if the decode location is at the
/// boundary of some sort of protection limit. For example, if one is
/// decoding near the end of a page and the XED user does not want to cause
/// extra page faults, one might send in the number of bytes that would
/// stop at the page boundary. In this case, XED might not be able to
/// decode the instruction and would return an error. The XED user would
/// then have to decide if it was safe to touch the next page and try again
/// to decode with more bytes.  Also sometimes the user process does not
/// have read access to the next page and this allows the user to prevent
/// XED from causing process termination by limiting the memory range that
/// XED will access.
///
/// @ingroup DEC

function xed_decode(xedd       : TXEDDecodedInstructionPtr;
                    const itext: Pbyte;
                    const bytes: UInt32): TXEDErrorEnum; cdecl; external 'xed.dll';

/// @file xed-encode.h
/// @ingroup ENC
/// Converts an decoder request to a valid encoder request.
procedure xed_encoder_request_init_from_decode(d: TXEDDecodedInstructionPtr); cdecl; external 'xed.dll';

/// @ingroup ENC
procedure xed_encoder_request_set_iclass( p: TXEDEncoderRequestPtr; iclass: TXED_iClass_Enum); cdecl; external 'xed.dll';

/// @name Operand Order
//@{
(*! @ingroup ENC
 * Specify the name as the n'th operand in the operand order.
 *
 * The complication of this function is that the register operand names are
 * specific to the position of the operand (REG0, REG1, REG2...). One can
 * use this function for registers or one can use the
 * xed_encoder_request_set_operand_name_reg() which takes integers instead
 * of operand names.
 *
 * @param[in] p                #xed_encoder_request_t
 * @param[in] operand_index    xed_uint_t representing n'th operand position
 * @param[in] name             #xed_operand_enum_t operand name.
 *)
procedure xed_encoder_request_set_operand_order(p: TXEDEncoderRequestPtr; operand_index: xed_uint_t; name: TXED_Operand_Enum);  cdecl; external 'xed.dll';

/// @name Immediates
//@{
/// @ingroup ENC
/// Set the uimm0 using a BYTE  width.
procedure xed_encoder_request_set_uimm0(p: TXEDEncoderRequestPtr; uimm: TXEDUnsignedInt64; nbytes: xed_uint_t);  cdecl; external 'xed.dll';

/// @file xed-decoded-inst-api.h
///
/// @ingroup DEC
/// Zero the decode structure completely. Re-initializes all operands.
procedure xed_decoded_inst_zero(p: TXEDDecodedInstructionPtr);  cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the machine mode and stack addressing width directly. This is NOT a
/// full initialization; Call #xed_decoded_inst_zero() before using this if
/// you want a clean slate.
procedure xed_decoded_inst_set_mode(p : TXEDDecodedInstructionPtr; mmode : TXEDMachineMode; stack_addr_width: TXEDAddressWidth);

/// @ingroup DEC
/// Return the #xed_inst_t structure for this instruction. This is the
/// route to the basic operands form information.
function xed_decoded_inst_inst( const p: TXEDDecodedInstructionPtr):TXEDInstructionPtr ;

/// @ingroup DEC
/// Return true if the instruction is valid
function xed_decoded_inst_valid(p : TXEDOperandValuesPtr): TXEDBool;

/// @ingroup DEC
/// Return the instruction #xed_category_enum_t enumeration
function xed_decoded_inst_get_category(const p: TXEDDecodedInstructionPtr): TXED_Category_Enum;

/// @ingroup DEC
/// Return the instruction #xed_extension_enum_t enumeration
function xed_decoded_inst_get_extension(const p: TXEDDecodedInstructionPtr): TXED_Extension_Enum;

/// @ingroup DEC
/// Return the instruction #xed_isa_set_enum_t enumeration
function xed_decoded_inst_get_isa_set(const p: TXEDDecodedInstructionPtr): TXEDIsaSetEnum;

/// @ingroup DEC
/// Return the instruction #xed_iclass_enum_t enumeration.
function xed_decoded_inst_get_iclass(const p: TXEDDecodedInstructionPtr): TXED_iClass_Enum;

/// @name xed_decoded_inst_t Length
//@{
/// @ingroup DEC
/// Return the length of the decoded  instruction in bytes.
function xed_decoded_inst_get_length(const p: TXEDDecodedInstructionPtr): xed_uint_t;

/// @name xed_decoded_inst_t get Byte
//@{
/// @ingroup DEC
/// Read itext byte.
function xed_decoded_inst_get_byte(const p: TXEDDecodedInstructionPtr; byte_index: Cardinal) : TXEDUnsignedInt8;

/// @name Modes
//@{
/// @ingroup DEC
/// Returns 16/32/64 indicating the machine mode with in bits. This is
/// derived from the input mode information.
function xed_decoded_inst_get_machine_mode_bits(const p: TXEDDecodedInstructionPtr): xed_uint_t;

/// @ingroup DEC
/// Returns 16/32/64 indicating the stack addressing mode with in
/// bits. This is derived from the input mode information.
function xed_decoded_inst_get_stack_address_mode_bits(const p: TXEDDecodedInstructionPtr) : xed_uint_t;

/// Returns the operand width in bits: 8/16/32/64. This is different than
/// the #xed_operand_values_get_effective_operand_width() which only
/// returns 16/32/64. This factors in the BYTEOP attribute when computing
/// its return value. This function provides a information for that is only
/// useful for (scalable) GPR-operations. Individual operands have more
/// specific information available from
/// #xed_decoded_inst_operand_element_size_bits()
/// @ingroup DEC
function xed_decoded_inst_get_operand_width(const p: TXEDDecodedInstructionPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';

/// Return the length in bits of the operand_index'th operand.
/// @ingroup DEC
function xed_decoded_inst_operand_length_bits(const p: TXEDDecodedInstructionPtr; operand_index: xed_uint_t): xed_uint_t; cdecl; external 'xed.dll';

/// @name xed_decoded_inst_t Operand Field Details
//@{
/// @ingroup DEC
function xed_decoded_inst_get_seg_reg(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal): TXED_Reg_Enum; cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_decoded_inst_get_base_reg(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal): TXED_Reg_Enum; cdecl; external 'xed.dll';

function xed_decoded_inst_get_index_reg(const p: TXEDDecodedInstructionPtr;mem_idx: Cardinal): TXED_Reg_Enum;  cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_decoded_inst_get_scale(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal):xed_uint_t; cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_decoded_inst_get_memory_displacement(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal): TXEDInt64;cdecl; external 'xed.dll';

/// @ingroup DEC
/// Result in BYTES
function xed_decoded_inst_get_memory_displacement_width(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal): xed_uint_t; cdecl; external 'xed.dll';
/// @ingroup DEC
/// Result in BITS
function xed_decoded_inst_get_memory_displacement_width_bits(const p: TXEDDecodedInstructionPtr; mem_idx: Cardinal): xed_uint_t; cdecl; external 'xed.dll';
/// @ingroup DEC
function xed_decoded_inst_get_branch_displacement(const p: TXEDDecodedInstructionPtr): TXEDInt32;  cdecl; external 'xed.dll';

/// @ingroup DEC
/// Result in BYTES
function xed_decoded_inst_get_branch_displacement_width(const p: TXEDDecodedInstructionPtr): xed_uint_t; cdecl; external 'xed.dll';

/// @ingroup DEC
/// Result in BITS
function xed_decoded_inst_get_branch_displacement_width_bits(const p: TXEDDecodedInstructionPtr): xed_uint_t; cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_decoded_inst_get_unsigned_immediate(const p: TXEDDecodedInstructionPtr): TXEDUnsignedInt64;cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return true if the first immediate (IMM0)  is signed
function xed_decoded_inst_get_immediate_is_signed(const p: TXEDDecodedInstructionPtr): xed_uint_t; cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return the immediate width in BYTES.
function xed_decoded_inst_get_immediate_width(const p: TXEDDecodedInstructionPtr): xed_uint_t; cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return the immediate width in BITS.
function xed_decoded_inst_get_immediate_width_bits(const p: TXEDDecodedInstructionPtr): xed_uint_t;cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_decoded_inst_get_signed_immediate(const p: TXEDDecodedInstructionPtr): TXEDInt32; cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return the specified register operand. The specifier is of type
/// #xed_operand_enum_t .
function xed_decoded_inst_get_reg(const p: TXEDDecodedInstructionPtr; reg_operand: TXED_Operand_Enum): TXED_Reg_Enum; cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return the instruction iform enum of type #xed_iform_enum_t .
function xed_decoded_inst_get_iform_enum(const p: TXEDDecodedInstructionPtr): TXED_iform_Enum;

/// @name xed_decoded_inst_t Operands
//@{
/// @ingroup DEC
/// Obtain a constant pointer to the operands
function xed_decoded_inst_operands_const(const p: TXEDDecodedInstructionPtr): TXEDOperandValuesPtr;

/// @ingroup DEC
function xed_decoded_inst_number_of_memory_operands(const p: TXEDDecodedInstructionPtr): xed_uint_t;cdecl; external 'xed.dll';
/// @ingroup DEC
function xed_decoded_inst_mem_read(const p: TXEDDecodedInstructionPtr; mem_idx: xed_uint_t): xed_bool_t; cdecl; external 'xed.dll';
/// @ingroup DEC
function xed_decoded_inst_mem_written(const p: TXEDDecodedInstructionPtr; mem_idx: xed_uint_t): xed_bool_t; cdecl; external 'xed.dll';
/// @ingroup DEC
function xed_decoded_inst_mem_written_only(const p: TXEDDecodedInstructionPtr; mem_idx: xed_uint_t): xed_bool_t; cdecl; external 'xed.dll';
/// @ingroup DEC
function xed_decoded_inst_conditionally_writes_registers(const p: TXEDDecodedInstructionPtr):xed_bool_t; cdecl; external 'xed.dll';
/// returns bytes
/// @ingroup DEC
function xed_decoded_inst_get_memory_operand_length(const p: TXEDDecodedInstructionPtr; memop_idx: xed_uint_t):xed_uint_t;cdecl; external 'xed.dll';

/// @ingroup DEC
/// Return the second immediate.
function xed_decoded_inst_get_second_immediate(const p: TXEDDecodedInstructionPtr):TXEDUnsignedInt8;

/// @name xed_decoded_inst_t Modification
//@{
// Modifying decoded instructions before re-encoding
/// @ingroup DEC
procedure xed_decoded_inst_set_scale(p: TXEDDecodedInstructionPtr; scale: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the memory displacement using a BYTE length
procedure xed_decoded_inst_set_memory_displacement(p: TXEDDecodedInstructionPtr; disp: TXEDInt64;length_bytes: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the branch  displacement using a BYTE length
procedure xed_decoded_inst_set_branch_displacement(p: TXEDDecodedInstructionPtr; disp: TXEDInt32; length_bytes: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the signed immediate a BYTE length
procedure xed_decoded_inst_set_immediate_signed(p: TXEDDecodedInstructionPtr;  x: TXEDInt32;length_bytes: xed_uint_t);cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the unsigned immediate a BYTE length
procedure xed_decoded_inst_set_immediate_unsigned(p: TXEDDecodedInstructionPtr; x: TXEDUnsignedInt64; length_bytes: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the memory displacement a BITS length
procedure xed_decoded_inst_set_memory_displacement_bits(p: TXEDDecodedInstructionPtr; disp: TXEDInt64; length_bits: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the branch displacement a BITS length
procedure xed_decoded_inst_set_branch_displacement_bits(p: TXEDDecodedInstructionPtr;  disp: TXEDInt32; length_bits: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the signed immediate a BITS length
procedure xed_decoded_inst_set_immediate_signed_bits(p: TXEDDecodedInstructionPtr; x: TXEDInt32; length_bits: xed_uint_t); cdecl; external 'xed.dll';

/// @ingroup DEC
/// Set the unsigned immediate a BITS length
procedure xed_decoded_inst_set_immediate_unsigned_bits(p: TXEDDecodedInstructionPtr; x: TXEDUnsignedInt64; length_bits: xed_uint_t); cdecl; external 'xed.dll';

/// See the comment on xed_decoded_inst_uses_rflags(). This can return
/// 0 if the flags are really not used by this instruction.
/// @ingroup DEC
function xed_decoded_inst_get_rflags_info( const p: TXEDDecodedInstructionPtr ): TXED_Simple_FlagPtr; cdecl; external 'xed.dll';

/// This returns 1 if the flags are read or written. This will return 0
/// otherwise. This will return 0 if the flags are really not used by this
/// instruction. For some shifts/rotates, XED puts a flags operand in the
/// operand array before it knows if the flags are used because of
/// mode-dependent masking effects on the immediate.
/// @ingroup DEC
function xed_decoded_inst_uses_rflags(const p: TXEDDecodedInstructionPtr): xed_bool_t; cdecl; external 'xed.dll';

/// @ingroup FLAGS
/// return union of bits for read flags
function xed_simple_flag_get_read_flag_set(const p: TXED_Simple_FlagPtr): TXED_Flag_SetPtr; cdecl; external 'xed.dll';

/// @ingroup FLAGS
/// return union of bits for written flags
function xed_simple_flag_get_written_flag_set(const p: TXED_Simple_FlagPtr): TXED_Flag_SetPtr; cdecl; external 'xed.dll';

///arbitrary sign extension from a qty of "bits" length to 64b
function xed_sign_extend_arbitrary_to_64(x: TXEDUnsignedInt64; bits: Cardinal): TXEDInt64; cdecl; external 'xed.dll';

/// @file xed-operand-values-interface.h
///
/// @ingroup OPERANDS
/// Set the mode values
procedure xed_operand_values_set_mode(p : TXEDOperandValuesPtr; const dstate: TXEDStatePtr); cdecl; external 'xed.dll';

/// @ingroup OPERANDS
/// True if there is a memory displacement
function xed_operand_values_has_memory_displacement(const p : TXEDOperandValuesPtr): xed_bool_t; cdecl; external 'xed.dll';

/// @ingroup OPERANDS
/// True if there is a branch displacement
function xed_operand_values_has_branch_displacement(const p : TXEDOperandValuesPtr): xed_bool_t; cdecl; external 'xed.dll';

/// @ingroup OPERANDS
/// True if there is a memory or branch displacement
function xed_operand_values_has_displacement(const p : TXEDOperandValuesPtr): xed_bool_t; cdecl; external 'xed.dll';

/// @ingroup PRINT
/// Print the instruction information in a verbose format.
/// This is for debugging.
/// @param p a #xed_decoded_inst_t for a decoded instruction
/// @param buf a buffer to write the disassembly in to.
/// @param buflen maximum length of the disassembly buffer
/// @param runtime_address the address of the instruction being disassembled. If zero, the offset is printed for relative branches. If nonzero, XED attempts to print the target address for relative branches.
/// @return Returns 0 if the disassembly fails, 1 otherwise.
function xed_decoded_inst_dump_xed_format(const p            : TXEDDecodedInstructionPtr;
                                              buf            : PAnsiChar;
                                              buflen         : Integer;
                                              runtime_address: TXEDUnsignedInt64): xed_bool_t ; cdecl; external 'xed.dll';


/// Disassemble the decoded instruction using the specified syntax.
/// The output buffer must be at least 25 bytes long. Returns true if
/// disassembly proceeded without errors.
/// @param syntax a #xed_syntax_enum_t the specifies the disassembly format
/// @param xedd a #xed_decoded_inst_t for a decoded instruction
/// @param out_buffer a buffer to write the disassembly in to.
/// @param buffer_len maximum length of the disassembly buffer
/// @param runtime_instruction_address the address of the instruction being disassembled. If zero, the offset is printed for relative branches. If nonzero, XED attempts to print the target address for relative branches.
/// @param context A void* used only for the call back routine for symbolic disassembly if one is provided. Can be zero.
/// @param symbolic_callback A function pointer for obtaining symbolic disassembly. Can be zero.
/// @return Returns 0 if the disassembly fails, 1 otherwise.
///@ingroup PRINT
function xed_format_context(syntax                     : TXED_Syntax_Enum;
                            const xedd                 : TXEDDecodedInstructionPtr;
                            out_buffer                 : PAnsiChar;
                            buffer_len                 : Integer;
                            runtime_instruction_address: TXEDUnsignedInt64;
                            context                    : Pointer;
                            symbolic_callback          : TXED_Disassembly_Callback_fn): xed_bool_t; cdecl; external 'xed.dll';

/// @file xed-inst.h
///

///@ingroup DEC
/// Number of instruction operands
function xed_inst_noperands(const  p: TXEDInstructionPtr): xed_uint_t;

///@ingroup DEC
/// Obtain a pointer to an individual operand
function xed_inst_operand(const p: TXEDInstructionPtr; i: xed_uint_t): TXED_OperandPtr; cdecl; external 'xed.dll';

/// @name xed_inst_t Template Operands Access
//@{
/// @ingroup DEC
function xed_operand_name(const p: TXED_OperandPtr): TXED_Operand_Enum;

/// @ingroup DEC
function xed_operand_operand_visibility( const p: TXED_OperandPtr): TXED_Operand_Visibility_Enum;

/// @ingroup DEC
/// @return The #xed_operand_type_enum_t of the operand template.
/// This is probably not what you want.
function xed_operand_type(const p: TXED_OperandPtr): TXED_Operand_Type_Enum;

/// @ingroup DEC
/// @return The #xed_operand_element_xtype_enum_t of the operand template.
/// This is probably not what you want.
function xed_operand_xtype(const p: TXED_OperandPtr): TXED_Operand_Element_Xtype_Enum;

/// @ingroup DEC
function xed_operand_width(const p: TXED_OperandPtr): TXED_Operand_Width_Enum;

/// @ingroup DEC
/// @param p  an operand template,  #xed_operand_t.
/// @param eosz  effective operand size of the instruction,  1 | 2 | 3 for
///  16 | 32 | 64 bits respectively. 0 is invalid.
/// @return  the actual width of operand in bits.
/// See xed_decoded_inst_operand_length_bits() for a more general solution.
function xed_operand_width_bits(const p: TXED_OperandPtr; const eosz: TXEDUnsignedInt32): TXEDUnsignedInt32; cdecl; external 'xed.dll';

/// @ingroup DEC
function xed_operand_nonterminal_name(const p: TXED_OperandPtr): TXED_Nonterminal_Enum;

/// @ingroup DEC
/// Careful with this one -- use #xed_decoded_inst_get_reg()! This one is
/// probably not what you think it is. It is only used for hard-coded
/// registers implicit in the instruction encoding. Most likely you want to
/// get the #xed_operand_enum_t and then look up the instruction using
/// #xed_decoded_inst_get_reg(). The hard-coded registers are also available
/// that way.
/// @param p  an operand template,  #xed_operand_t.
/// @return  the implicit or suppressed registers, type #xed_reg_enum_t
function xed_operand_reg(const p: TXED_OperandPtr): TXED_Reg_Enum;

/// @ingroup DEC
/// Careful with this one; See #xed_operand_is_register().
/// @param p  an operand template,  #xed_operand_t.
/// @return 1 if the operand template represents are register-type
/// operand.
///
///  Related functions:
///   Use #xed_decoded_inst_get_reg() to get the decoded name of /// the
///   register, #xed_reg_enum_t. Use #xed_operand_is_register() to test
///   #xed_operand_enum_t names.
function xed_operand_template_is_register(const p: TXED_OperandPtr): Boolean;

/// @ingroup DEC
/// @param p  an operand template,  #xed_operand_t.
/// These operands represent branch displacements, memory displacements and
/// various immediates
function xed_operand_imm(const p: TXED_OperandPtr): TXEDUnsignedInt32;

/// @ingroup DEC
/// Print the operand p into the buffer buf, of length buflen.
/// @param p  an operand template,  #xed_operand_t.
/// @param buf buffer that gets filled in
/// @param buflen maximum buffer length
procedure xed_operand_print(const p: TXED_OperandPtr; buf: PAnsiChar; buflen: Integer); cdecl; external 'xed.dll';

/// @name xed_inst_t Template Operand Enum Name Classification
//@{
/// @ingroup DEC
/// Tests the enum for inclusion in XED_OPERAND_REG0 through XED_OPERAND_REG9.
/// @param name the operand name, type #xed_operand_enum_t
/// @return 1 if the operand name is REG0...REG9, 0 otherwise.
///
///Note there are other registers for memory addressing; See
/// #xed_operand_is_memory_addressing_register .
function xed_operand_is_register(name: TXED_Operand_Enum): Boolean;

/// @ingroup DEC
/// Tests the enum for inclusion in XED_OPERAND_{BASE0,BASE1,INDEX,SEG0,SEG1}
/// @param name the operand name, type #xed_operand_enum_t
/// @return 1 if the operand name is for a memory addressing register operand, 0
/// otherwise. See also #xed_operand_is_register .
function xed_operand_is_memory_addressing_register(name: TXED_Operand_Enum): Boolean;

/// @ingroup DEC
/// DEPRECATED: Returns the raw R/W action. There are many cases for conditional reads
/// and writes. See #xed_decoded_inst_operand_action().
function xed_operand_rw(const p: TXED_OperandPtr): TXED_Operand_Action_Enum;

/// @ingroup DEC
/// If the operand is read, including conditional reads
function xed_operand_read(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand is read-only, including conditional reads
function xed_operand_read_only(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand is written, including conditional writes
function xed_operand_written(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand is written-only, including conditional writes
function xed_operand_written_only(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand is read-and-written, conditional reads and conditional writes
function xed_operand_read_and_written(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand has a conditional read (may also write)
function xed_operand_conditional_read(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';
/// @ingroup DEC
/// If the operand has a conditional write (may also read)
function xed_operand_conditional_write(const p: TXED_OperandPtr): TXEDUnsignedInt32; cdecl; external 'xed.dll';

function xed3_operand_get_mode(const d: TXEDDecodedInstructionPtr) : xed_bits_t;
function xed3_operand_get_smode(const d: TXEDDecodedInstructionPtr) : xed_bits_t;
function xed3_operand_get_uimm1(const d: TXEDDecodedInstructionPtr) : TXEDUnsignedInt8;

function xed_inst_iform_enum(const p: TXEDInstructionPtr): TXED_iform_Enum;

/// @file xed-iform-map.h
///
/// @ingroup IFORM
/// Map the #xed_iform_enum_t to a pointer to a #xed_iform_info_t which
/// indicates the #xed_iclass_enum_t, the #xed_category_enum_t and the
/// #xed_extension_enum_t for the iform. Returns 0 if the iform is not a
/// valid iform.
function xed_iform_map(iform: TXED_iform_Enum): TXED_iform_infoPtr; cdecl; external 'xed.dll';

/// @ingroup IFORM
/// Return the maximum number of iforms for a particular iclass.  This
/// function returns valid data as soon as global data is
/// initialized. (This function does not require a decoded instruction as
/// input).
function xed_iform_max_per_iclass(iclass: TXED_iClass_Enum):TXEDUnsignedInt32; cdecl; external 'xed.dll';

/// @ingroup IFORM
/// Return the first of the iforms for a particular iclass.  This function
/// returns valid data as soon as global data is initialized. (This
/// function does not require a decoded instruction as input).
function xed_iform_first_per_iclass(iclass: TXED_iClass_Enum): TXEDUnsignedInt32; cdecl; external 'xed.dll';

/// @ingroup IFORM
/// Return the iclass for a given iform. This
/// function returns valid data as soon as global data is initialized. (This
/// function does not require a decoded instruction as input).
function xed_iform_to_iclass(iform: TXED_iform_Enum): TXED_iClass_Enum;

/// @ingroup IFORM
/// Return the category for a given iform. This
/// function returns valid data as soon as global data is initialized. (This
/// function does not require a decoded instruction as input).
function xed_iform_to_category(iform: TXED_iform_Enum): TXED_Category_Enum; cdecl; external 'xed.dll'

/// @ingroup IFORM
/// Return the extension for a given iform. This function returns valid
/// data as soon as global data is initialized. (This function does not
/// require a decoded instruction as input).
function xed_iform_to_extension(iform: TXED_iform_Enum): TXED_Extension_Enum; cdecl; external 'xed.dll'

/// @ingroup IFORM
/// Return the isa_set for a given iform. This function returns valid data
/// as soon as global data is initialized. (This function does not require
/// a decoded instruction as input).
function xed_iform_to_isa_set(iform: TXED_iform_Enum): TXEDIsaSetEnum; cdecl; external 'xed.dll'

/// @ingroup IFORM
/// Return a pointer to a character string of the iclass. This
/// translates the internal disambiguated names to the more ambiguous
/// names that people like to see. This returns the ATT SYSV-syntax name.
function xed_iform_to_iclass_string_att(iform: TXED_iform_Enum): PAnsiChar;cdecl; external 'xed.dll'


/// @ingroup IFORM
/// Return a pointer to a character string of the iclass. This
/// translates the internal disambiguated names to the more ambiguous
/// names that people like to see. This returns the Intel-syntax name.
function xed_iform_to_iclass_string_intel(iform: TXED_iform_Enum): PAnsiChar; cdecl; external 'xed.dll'
///

function xed_inst_iclass(const p: TXEDInstructionPtr): TXED_iClass_Enum;

function xed_inst_category(const p: TXEDInstructionPtr): TXED_Category_Enum ;

function xed_inst_extension(const p: TXEDInstructionPtr): TXED_Extension_Enum;

function xed_inst_isa_set(const p: TXEDInstructionPtr): TXEDIsaSetEnum;

/// Returns the register class of the given input register.
///@ingroup REGINTFC
function xed_reg_class(r: TXED_Reg_Enum): TXED_Reg_Class_enum; cdecl; external 'xed.dll' ;

/// Returns the specific width GPR reg class (like XED_REG_CLASS_GPR32 or
///  XED_REG_CLASS_GPR64)
///  for a given GPR register. Or XED_REG_INVALID if not a GPR.
///@ingroup REGINTFC
function xed_gpr_reg_class(r: TXED_Reg_Enum): TXED_Reg_Class_enum; cdecl; external 'xed.dll' ;

/// Returns the largest enclosing register for any kind of register; This
/// is mostly useful for GPRs. (64b mode assumed)
///@ingroup REGINTFC
function xed_get_largest_enclosing_register(r: TXED_Reg_Enum): TXED_Reg_Enum; cdecl; external 'xed.dll' ;

/// Returns the largest enclosing register for any kind of register; This
/// is mostly useful for GPRs in 32b mode.
///@ingroup REGINTFC
function xed_get_largest_enclosing_register32(r: TXED_Reg_Enum): TXED_Reg_Enum; cdecl; external 'xed.dll' ;

/// Returns the  width, in bits, of the named register. 32b mode
///@ingroup REGINTFC
function xed_get_register_width_bits(r: TXED_Reg_Enum): TXEDUnsignedInt32; cdecl; external 'xed.dll' ;

/// Returns the  width, in bits, of the named register. 64b mode.
///@ingroup REGINTFC
function xed_get_register_width_bits64(r: TXED_Reg_Enum): TXEDUnsignedInt32; cdecl; external 'xed.dll' ;

implementation

procedure xed_decoded_inst_set_mode(p : TXEDDecodedInstructionPtr; mmode  : TXEDMachineMode;stack_addr_width: TXEDAddressWidth); inline ;
var
  dstate : TXEDState;
begin
     dstate.mmode := mmode;
     dstate.stack_addr_width := stack_addr_width;
     xed_operand_values_set_mode(p, @dstate);
end;

function xed_decoded_inst_inst( const p: TXEDDecodedInstructionPtr):TXEDInstructionPtr ; inline ;
begin
    Result := p^._inst;
end;

function xed_decoded_inst_valid(p : TXEDOperandValuesPtr): TXEDBool; inline ;
begin
    Result := Assigned(p^._inst)
end;

function xed_decoded_inst_get_category(const p: TXEDDecodedInstructionPtr): TXED_Category_Enum; inline ;
begin
    Assert(p^._inst <> nil);
    Result :=  xed_inst_category(p._inst);
end;

function xed_decoded_inst_get_extension(const p: TXEDDecodedInstructionPtr): TXED_Extension_Enum;inline ;
begin
    Assert(p^._inst <> nil);
    Result := xed_inst_extension(p^._inst);
end;

function xed_decoded_inst_get_isa_set(const p: TXEDDecodedInstructionPtr): TXEDIsaSetEnum;inline ;
begin
    Assert(p^._inst <> nil);
    Result :=  xed_inst_isa_set(p^._inst);
end;

function xed_decoded_inst_get_iclass(const p: TXEDDecodedInstructionPtr): TXED_iClass_Enum; inline ;
begin
    Assert(p^._inst <> nil);
    Result :=  xed_inst_iclass(p^._inst);
end;

function xed_decoded_inst_get_length(const p: TXEDDecodedInstructionPtr): xed_uint_t;
begin
    Result :=  p^._decoded_length;
end;

function xed_decoded_inst_get_byte(const p: TXEDDecodedInstructionPtr; byte_index: Cardinal) : TXEDUnsignedInt8;
var
  b : TXEDUnsignedInt8;
begin
    /// Read a whole byte from the normal input bytes.
    b := p^._byte_array._dec[byte_index];
    Result := b;
end;

function xed_decoded_inst_get_machine_mode_bits(const p: TXEDDecodedInstructionPtr): xed_uint_t;
var
  mode : TXEDUnsignedInt8;
begin
    mode := xed3_operand_get_mode(p);
    if (mode = 2) then Exit(64);
    if (mode = 1) then Exit(32);
    Result := 16;
end;

function xed_decoded_inst_get_stack_address_mode_bits(const p: TXEDDecodedInstructionPtr) : xed_uint_t;
var
  smode : TXEDUnsignedInt8;
begin
    smode := xed3_operand_get_smode(p);
    if (smode = 2) then Exit(64);
    if (smode = 1) then Exit(32);
    Exit(16);
end;

function xed_decoded_inst_get_iform_enum(const p: TXEDDecodedInstructionPtr): TXED_iform_Enum;
begin
    assert(p^._inst <> nil);
    Result := TXED_iform_Enum(p^._inst);
end;

function xed_decoded_inst_operands_const(const p: TXEDDecodedInstructionPtr): TXEDOperandValuesPtr;
begin
    Result := p;
end;

function xed3_operand_get_uimm1(const d: TXEDDecodedInstructionPtr) : TXEDUnsignedInt8;
begin
   Result := TXEDUnsignedInt8(d^._operands.uimm1);
end;

function xed_decoded_inst_get_second_immediate(const p: TXEDDecodedInstructionPtr):TXEDUnsignedInt8;
begin
    Result := xed3_operand_get_uimm1(p);
end;

function xed3_operand_get_mode(const d: TXEDDecodedInstructionPtr) : xed_bits_t;
begin
    Result := xed_bits_t(d._operands.mode);
end;

function xed3_operand_get_smode(const d: TXEDDecodedInstructionPtr) : xed_bits_t;
begin
    Result := xed_bits_t(d._operands.smode);
end;

function xed_inst_iform_enum(const p: TXEDInstructionPtr): TXED_iform_Enum; inline ;
begin
    Result := TXED_iform_Enum(p^._iform_enum);
end;

function xed_inst_noperands(const  p: TXEDInstructionPtr): TXEDUnsignedInt32; inline ;
begin
    Result := p^._noperands;
end;

function xed_operand_name(const p: TXED_OperandPtr): TXED_Operand_Enum; inline ;
begin
    Result :=  TXED_Operand_Enum(p^._name);
end;

function xed_operand_operand_visibility( const p: TXED_OperandPtr): TXED_Operand_Visibility_Enum; inline ;
begin
    Result := TXED_Operand_Visibility_Enum(p^._operand_visibility);
end;

function xed_operand_type(const p: TXED_OperandPtr): TXED_Operand_Type_Enum; inline ;
begin
     Result := TXED_Operand_Type_Enum(p^._type);
end;

function xed_operand_xtype(const p: TXED_OperandPtr): TXED_Operand_Element_Xtype_Enum; inline ;
begin
    Result := TXED_Operand_Element_Xtype_Enum(p^._xtype);
end;

function xed_operand_width(const p: TXED_OperandPtr): TXED_Operand_Width_Enum; inline ;
begin
    Result := TXED_Operand_Width_Enum(p^._oc2);
end;

function xed_operand_nonterminal_name(const p: TXED_OperandPtr): TXED_Nonterminal_Enum; inline ;
begin
    if p^._nt <> 0 then Exit(p^.u._nt);

    Result := XED_NONTERMINAL_INVALID;
end;

function xed_operand_reg(const p: TXED_OperandPtr): TXED_Reg_Enum;  inline ;
Begin
    if xed_operand_type(p) = XED_OPERAND_TYPE_REG then
        exit(p^.u._reg);

    Result := XED_REG_INVALID;
End;

function xed_operand_template_is_register(const p: TXED_OperandPtr): Boolean;
begin
    Result :=  (p^._nt <> 0) or (TXED_Operand_Type_Enum(p^._type) = XED_OPERAND_TYPE_REG) ;
end;

function xed_operand_imm(const p: TXED_OperandPtr): TXEDUnsignedInt32; inline ;
begin
    if TXED_Operand_Type_Enum(p) = XED_OPERAND_TYPE_IMM_CONST then
        Exit(p^.u._imm);

    Result := 0;
end;

function xed_operand_is_register(name: TXED_Operand_Enum): Boolean;  inline ;
begin
    Result :=  (name >= XED_OPERAND_REG0) and (name <= XED_OPERAND_REG9);
end;

function xed_operand_is_memory_addressing_register(name: TXED_Operand_Enum): Boolean;  inline ;
begin
    Result := ( name = XED_OPERAND_BASE0) or
              ( name = XED_OPERAND_INDEX) or
              ( name = XED_OPERAND_SEG0)  or
              ( name = XED_OPERAND_BASE1) or
              ( name = XED_OPERAND_SEG1);
end;

function xed_operand_rw(const p: TXED_OperandPtr): TXED_Operand_Action_Enum;
begin
   Result :=  TXED_Operand_Action_Enum(p^._rw);
end;

function xed_iform_to_iclass(iform: TXED_iform_Enum): TXED_iClass_Enum; inline ;
var
  ii : TXED_iform_infoPtr;
begin
    ii := xed_iform_map(iform);
    if Assigned(ii) then
        Exit( TXED_iClass_Enum(ii^.iclass));
    Result :=  XED_ICLASS_INVALID;
end;

function xed_inst_iclass(const p: TXEDInstructionPtr): TXED_iClass_Enum; inline ;
begin
    Result :=  xed_iform_to_iclass( xed_inst_iform_enum(p) );
end;

function xed_inst_category(const p: TXEDInstructionPtr): TXED_Category_Enum ; inline ;
begin
    Result :=  xed_iform_to_category( xed_inst_iform_enum(p) );
end;

function xed_inst_extension(const p: TXEDInstructionPtr): TXED_Extension_Enum;inline ;
begin
    Result :=  xed_iform_to_extension( xed_inst_iform_enum(p) );
end;

function xed_inst_isa_set(const p: TXEDInstructionPtr): TXEDIsaSetEnum;  inline ;
begin
    Result :=  xed_iform_to_isa_set( xed_inst_iform_enum(p) );
end;

initialization
  xed_tables_init();
end.
