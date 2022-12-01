package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.FakeHistory;

public interface FakeHistoryRepository extends JpaRepository<FakeHistory, String> {

	@Query(value="select fh_code,fh_poster_path,pf_code from fakehistory where pf_code= :pf_code",nativeQuery = true)
	List<FakeHistory> findByHistory(@Param("pf_code") String pf_code);
}
