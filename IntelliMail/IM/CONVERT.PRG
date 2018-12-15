set talk off
set echo off

select 1
use client
zap

select 2
use tmpcli

do while .not. (bof() .or. eof())
    store c_cli_nbr to m_cli_nbr
    store c_birth to m_birth
    store c_lst_n to m_lst_n
    store c_fst_n to m_fst_n
    store c_m_i to m_m_i
    store c_street to m_street
    store c_city to m_city
    store c_state to m_state
    store c_zip to m_zip
    store c_phone to m_phone
    store c_comments to m_comments
    store c_logon to m_logon

    select 1
    append blank

    replace c_cli_nbr with m_cli_nbr
    replace c_birth with m_birth
    replace c_lst_n with m_lst_n
    replace c_fst_n with m_fst_n
    replace c_m_i with m_m_i
    replace c_addr_1 with m_street
    replace c_city with m_city
    replace c_state with m_state
    replace c_zip with m_zip
    replace c_phone with m_phone
    replace c_comments with m_comments
    replace c_logon with m_logon
    select 2
    skip

enddo

select 1
use
select 2
use
