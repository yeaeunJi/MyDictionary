-- 회원(백과사전)
CREATE TABLE `dictUser` (
	`userNo`   INT UNSIGNED NOT NULL COMMENT '회원번호', -- 회원번호
	`name`     VARCHAR(50)  NOT NULL COMMENT '이름', -- 이름
	`id`       VARCHAR(200) NOT NULL COMMENT '아이디', -- 아이디
	`password` VARCHAR(20)  NOT NULL COMMENT '비밀번호', -- 비밀번호
	`joinDate` DATETIME     NOT NULL DEFAULT now() COMMENT '가입일' -- 가입일
)
COMMENT '회원(백과사전)';

-- 회원(백과사전)
ALTER TABLE `dictUser`
	ADD CONSTRAINT `PK_dictUser` -- 회원(백과사전) 기본키
		PRIMARY KEY (
			`userNo` -- 회원번호
		);

ALTER TABLE `dictUser`
	MODIFY COLUMN `userNo` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '회원번호';

-- 즐겨찾기
CREATE TABLE `bookmark` (
	`wordNo`      INT UNSIGNED  NOT NULL COMMENT '단어번호', -- 단어번호
	`bmkListNo`   INT UNSIGNED  NOT NULL COMMENT '즐겨찾기목록번호', -- 즐겨찾기목록번호
	`userNo`      VARCHAR(200)  NOT NULL COMMENT '회원번호', -- 회원번호
	`title`       VARCHAR(200)  NOT NULL COMMENT '제목', -- 제목
	`regDate`     DATETIME      NOT NULL COMMENT '등록일', -- 등록일
	`link`        VARCHAR(2000) NOT NULL COMMENT '링크', -- 링크
	`keyword`     VARCHAR(2000) NULL     COMMENT '검색키워드', -- 검색키워드
	`thumbnail`   VARCHAR(2000) NULL     COMMENT '썸네일', -- 썸네일
	`description` VARCHAR(2000) NULL     COMMENT '요약' -- 요약
)
COMMENT '즐겨찾기';

-- 즐겨찾기
ALTER TABLE `bookmark`
	ADD CONSTRAINT `PK_bookmark` -- 즐겨찾기 기본키
		PRIMARY KEY (
			`wordNo` -- 단어번호
		);

ALTER TABLE `bookmark`
	MODIFY COLUMN `wordNo` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '단어번호';

-- 즐겨찾기목록
CREATE TABLE `bookmarklist` (
	`bmkListNo` INT UNSIGNED NOT NULL COMMENT '즐겨찾기목록번호', -- 즐겨찾기목록번호
	`userNo`    INT UNSIGNED NOT NULL COMMENT '회원번호', -- 회원번호
	`title`     VARCHAR(30)  NOT NULL DEFAULT "기본" COMMENT '이름', -- 이름
	`wordCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '단어수' -- 단어수
)
COMMENT '즐겨찾기목록';

-- 즐겨찾기목록
ALTER TABLE `bookmarklist`
	ADD CONSTRAINT `PK_bookmarklist` -- 즐겨찾기목록 기본키
		PRIMARY KEY (
			`bmkListNo` -- 즐겨찾기목록번호
		);

ALTER TABLE `bookmarklist`
	MODIFY COLUMN `bmkListNo` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '즐겨찾기목록번호';

-- 자유게시판
CREATE TABLE `tbl_board` (
	`bid`      INT UNSIGNED  NOT NULL COMMENT '일련번호', -- 일련번호
	`cate_cd`  VARCHAR(20)   NULL     COMMENT '게시글 카테고리', -- 게시글 카테고리
	`title`    VARCHAR(200)  NOT NULL COMMENT '제목', -- 제목
	`content`  TEXT          NOT NULL COMMENT '게시글', -- 게시글
	`tag`      VARCHAR(1000) NOT NULL DEFAULT "" COMMENT '태그', -- 태그
	`view_cnt` INT UNSIGNED  NOT NULL DEFAULT 0 COMMENT '카운트', -- 카운트
	`reg_id`   VARCHAR(200)  NOT NULL COMMENT '작성자', -- 작성자
	`reg_dt`   DATE          NOT NULL COMMENT '작성일', -- 작성일
	`edit_dt`  DATE          NOT NULL COMMENT '수정일' -- 수정일
)
COMMENT '자유게시판';

-- 자유게시판
ALTER TABLE `tbl_board`
	ADD CONSTRAINT `PK_tbl_board` -- 자유게시판 기본키
		PRIMARY KEY (
			`bid` -- 일련번호
		);

ALTER TABLE `tbl_board`
	MODIFY COLUMN `bid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '일련번호';

-- 자유게시판 댓글
CREATE TABLE `tbl_reply` (
	`rid`     INT UNSIGNED NOT NULL COMMENT '일련번호', -- 일련번호
	`bid`     INT UNSIGNED NOT NULL COMMENT '게시물 일련번호', -- 게시물 일련번호
	`content` TEXT         NULL     COMMENT '댓글내용', -- 댓글내용
	`reg_id`  VARCHAR(200) NOT NULL COMMENT '작성자', -- 작성자
	`reg_dt`  TIMESTAMP    NOT NULL COMMENT '작성일', -- 작성일
	`edit_dt` TIMESTAMP    NOT NULL COMMENT '수정일' -- 수정일
)
COMMENT '자유게시판 댓글';

-- 자유게시판 댓글
ALTER TABLE `tbl_reply`
	ADD CONSTRAINT `PK_tbl_reply` -- 자유게시판 댓글 기본키
		PRIMARY KEY (
			`rid` -- 일련번호
		);

ALTER TABLE `tbl_reply`
	MODIFY COLUMN `rid` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '일련번호';

-- 1:1문의
CREATE TABLE `oneToOne` (
	`no`      INT UNSIGNED NOT NULL COMMENT '문의번호', -- 문의번호
	`title`   VARCHAR(100) NOT NULL COMMENT '제목', -- 제목
	`content` TEXT         NOT NULL COMMENT '내용', -- 내용
	`writer`  VARCHAR(200) NOT NULL COMMENT '작성자', -- 작성자
	`regdate` DATETIME     NOT NULL COMMENT '작성일', -- 작성일
	`reply`   TEXT         NULL     COMMENT '답변' -- 답변
)
COMMENT '1:1문의';

-- 1:1문의
ALTER TABLE `oneToOne`
	ADD CONSTRAINT `PK_oneToOne` -- 1:1문의 기본키
		PRIMARY KEY (
			`no` -- 문의번호
		);

ALTER TABLE `oneToOne`
	MODIFY COLUMN `no` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '문의번호';

-- 즐겨찾기
ALTER TABLE `bookmark`
	ADD CONSTRAINT `FK_bookmarklist_TO_bookmark` -- 즐겨찾기목록 -> 즐겨찾기
		FOREIGN KEY (
			`bmkListNo` -- 즐겨찾기목록번호
		)
		REFERENCES `bookmarklist` ( -- 즐겨찾기목록
			`bmkListNo` -- 즐겨찾기목록번호
		),
	ADD INDEX `FK_bookmarklist_TO_bookmark` (
		`bmkListNo` ASC -- 즐겨찾기목록번호
	);

-- 즐겨찾기목록
ALTER TABLE `bookmarklist`
	ADD CONSTRAINT `FK_dictUser_TO_bookmarklist` -- 회원(백과사전) -> 즐겨찾기목록
		FOREIGN KEY (
			`userNo` -- 회원번호
		)
		REFERENCES `dictUser` ( -- 회원(백과사전)
			`userNo` -- 회원번호
		),
	ADD INDEX `FK_dictUser_TO_bookmarklist` (
		`userNo` ASC -- 회원번호
	);

-- 자유게시판 댓글
ALTER TABLE `tbl_reply`
	ADD CONSTRAINT `FK_tbl_board_TO_tbl_reply` -- 자유게시판 -> 자유게시판 댓글
		FOREIGN KEY (
			`bid` -- 게시물 일련번호
		)
		REFERENCES `tbl_board` ( -- 자유게시판
			`bid` -- 일련번호
		);