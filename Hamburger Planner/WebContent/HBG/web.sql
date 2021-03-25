drop sequence hbg_seq_board_no;
drop sequence hbg_seq_user_no;

drop table hbg_service;
drop table hbg_board_cldar;
drop table hbg_board_clist;
drop table hbg_board_memo;
drop table hbg_board;
drop table hbg_user;

create table hbg_user (
	user_no number not null,
	user_email varchar2(100) not null unique,
	user_pass varchar2(255) not null,
	user_name varchar2(100) not null,
	user_activation_key varchar2(255) default '1' not null,
	user_status varchar2(1) default '1' not null,
	user_regdate date default sysdate not null,
	user_image varchar2(255),
	CONSTRAINT hbg_pk_user_no PRIMARY KEY (user_no)
);

create sequence hbg_seq_user_no start with 1 increment by 1;

create table hbg_board (
	board_no number not null,
	board_type varchar2(20) not null,
	board_auth varchar2(3) default '111' not null,
	board_update date default sysdate not null,
	board_regdate date default sysdate not null,
	CONSTRAINT hbg_pk_board_no PRIMARY KEY (board_no)
);

create sequence hbg_seq_board_no start with 1 increment by 1;

create table hbg_board_memo (
	board_no number not null,
	memo_content varchar2(1000),
	CONSTRAINT hbg_fk_board_memo FOREIGN KEY (board_no) REFERENCES hbg_board(board_no) on delete cascade,
	CONSTRAINT hbg_pk_board_memo PRIMARY KEY (board_no) 	
);

create table hbg_board_clist (
	board_no number not null,
	clist_check1 number(1) default 0 not null,
	clist_content1 varchar2(255),
	clist_check2 number(1) default 0 not null,
	clist_content2 varchar2(255),
	clist_check3 number(1) default 0 not null,
	clist_content3 varchar2(255),
	clist_check4 number(1) default 0 not null,
	clist_content4 varchar2(255),
	clist_check5 number(1) default 0 not null,
	clist_content5 varchar2(255),
	CONSTRAINT hbg_fk_board_clist FOREIGN KEY (board_no) REFERENCES hbg_board(board_no) on delete cascade,
	CONSTRAINT hbg_pk_board_clist PRIMARY KEY (board_no)
);

create table hbg_board_cldar (
	board_no number not null,
	CONSTRAINT hbg_fk_board_cldar FOREIGN KEY (board_no) REFERENCES hbg_board(board_no) on delete cascade,
	CONSTRAINT hbg_pk_board_cldar PRIMARY KEY (board_no)
);

create table hbg_service (
	user_no number not null,
	board_no number not null,
	user_grade varchar2(1) default 1 not null,
	board_order number(2) default 99 not null,
	board_title varchar2(50) default 'NEW BOARD' not null,
	CONSTRAINT hbg_fk_serv_user FOREIGN KEY (user_no) REFERENCES hbg_user(user_no) on delete cascade,
	CONSTRAINT hbg_fk_serv_board FOREIGN KEY (board_no) REFERENCES hbg_board(board_no),
	CONSTRAINT hbg_pk_serv PRIMARY KEY (user_no, board_no)
);

commit;
