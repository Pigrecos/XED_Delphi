unit XED.CategoryEnum;

{$Z4}
interface

type
  TXED_Category_Enum = (
    XED_CATEGORY_INVALID,
    XED_CATEGORY_3DNOW,
    XED_CATEGORY_ADOX_ADCX,
    XED_CATEGORY_AES,
    XED_CATEGORY_AMX_TILE,
    XED_CATEGORY_AVX,
    XED_CATEGORY_AVX2,
    XED_CATEGORY_AVX2GATHER,
    XED_CATEGORY_AVX512,
    XED_CATEGORY_AVX512_4FMAPS,
    XED_CATEGORY_AVX512_4VNNIW,
    XED_CATEGORY_AVX512_BITALG,
    XED_CATEGORY_AVX512_VBMI,
    XED_CATEGORY_AVX512_VP2INTERSECT,
    XED_CATEGORY_BINARY,
    XED_CATEGORY_BITBYTE,
    XED_CATEGORY_BLEND,
    XED_CATEGORY_BMI1,
    XED_CATEGORY_BMI2,
    XED_CATEGORY_BROADCAST,
    XED_CATEGORY_CALL,
    XED_CATEGORY_CET,
    XED_CATEGORY_CLDEMOTE,
    XED_CATEGORY_CLFLUSHOPT,
    XED_CATEGORY_CLWB,
    XED_CATEGORY_CLZERO,
    XED_CATEGORY_CMOV,
    XED_CATEGORY_COMPRESS,
    XED_CATEGORY_COND_BR,
    XED_CATEGORY_CONFLICT,
    XED_CATEGORY_CONVERT,
    XED_CATEGORY_DATAXFER,
    XED_CATEGORY_DECIMAL,
    XED_CATEGORY_ENQCMD,
    XED_CATEGORY_EXPAND,
    XED_CATEGORY_FCMOV,
    XED_CATEGORY_FLAGOP,
    XED_CATEGORY_FMA4,
    XED_CATEGORY_FP16,
    XED_CATEGORY_GATHER,
    XED_CATEGORY_GFNI,
    XED_CATEGORY_HRESET,
    XED_CATEGORY_IFMA,
    XED_CATEGORY_INTERRUPT,
    XED_CATEGORY_IO,
    XED_CATEGORY_IOSTRINGOP,
    XED_CATEGORY_KEYLOCKER,
    XED_CATEGORY_KEYLOCKER_WIDE,
    XED_CATEGORY_KMASK,
    XED_CATEGORY_LEGACY,
    XED_CATEGORY_LOGICAL,
    XED_CATEGORY_LOGICAL_FP,
    XED_CATEGORY_LZCNT,
    XED_CATEGORY_MISC,
    XED_CATEGORY_MMX,
    XED_CATEGORY_MOVDIR,
    XED_CATEGORY_MPX,
    XED_CATEGORY_NOP,
    XED_CATEGORY_PCLMULQDQ,
    XED_CATEGORY_PCONFIG,
    XED_CATEGORY_PKU,
    XED_CATEGORY_POP,
    XED_CATEGORY_PREFETCH,
    XED_CATEGORY_PREFETCHWT1,
    XED_CATEGORY_PTWRITE,
    XED_CATEGORY_PUSH,
    XED_CATEGORY_RDPID,
    XED_CATEGORY_RDPRU,
    XED_CATEGORY_RDRAND,
    XED_CATEGORY_RDSEED,
    XED_CATEGORY_RDWRFSGS,
    XED_CATEGORY_RET,
    XED_CATEGORY_ROTATE,
    XED_CATEGORY_SCATTER,
    XED_CATEGORY_SEGOP,
    XED_CATEGORY_SEMAPHORE,
    XED_CATEGORY_SERIALIZE,
    XED_CATEGORY_SETCC,
    XED_CATEGORY_SGX,
    XED_CATEGORY_SHA,
    XED_CATEGORY_SHIFT,
    XED_CATEGORY_SMAP,
    XED_CATEGORY_SSE,
    XED_CATEGORY_STRINGOP,
    XED_CATEGORY_STTNI,
    XED_CATEGORY_SYSCALL,
    XED_CATEGORY_SYSRET,
    XED_CATEGORY_SYSTEM,
    XED_CATEGORY_TBM,
    XED_CATEGORY_TSX_LDTRK,
    XED_CATEGORY_UINTR,
    XED_CATEGORY_UNCOND_BR,
    XED_CATEGORY_VAES,
    XED_CATEGORY_VBMI2,
    XED_CATEGORY_VEX,
    XED_CATEGORY_VFMA,
    XED_CATEGORY_VIA_PADLOCK,
    XED_CATEGORY_VPCLMULQDQ,
    XED_CATEGORY_VTX,
    XED_CATEGORY_WAITPKG,
    XED_CATEGORY_WIDENOP,
    XED_CATEGORY_X87_ALU,
    XED_CATEGORY_XOP,
    XED_CATEGORY_XSAVE,
    XED_CATEGORY_XSAVEOPT,
    XED_CATEGORY_LAST);

/// This converts strings to #xed_category_enum_t types.
/// @param s A C-string.
/// @return #xed_category_enum_t
/// @ingroup ENUM
function str2xed_category_enum_t(s: PAnsiChar): TXED_Category_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_category_enum_t types.
/// @param p An enumeration element of type xed_category_enum_t.
/// @return string
/// @ingroup ENUM
function xed_category_enum_t2str(const p: TXED_Category_Enum): PAnsiChar; cdecl; external 'xed.dll';
/// Returns the last element of the enumeration
/// @return xed_category_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_category_enum_t_last:TXED_Category_Enum;cdecl; external 'xed.dll';

implementation

end.
