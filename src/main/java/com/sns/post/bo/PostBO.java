package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.dao.PostRepository;
import com.sns.post.entity.PostEntity;

@Service
public class PostBO {

	@Autowired
	private PostRepository postRepository;

	@Autowired
	private FileManagerService fileManager;

	public List<PostEntity> getPostList() {
		return postRepository.findAllByOrderByIdDesc();
	}

	public Integer addPost(int userId, String userLoginId, String content, MultipartFile file) {

		String imagePath = null;

		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
		}

		PostEntity postEntity = postRepository
				.save(PostEntity.builder()
						.userId(userId)
						.content(content)
						.imagePath(imagePath)
						.build());

		return postEntity == null ? null : postEntity.getId();
	}
	
//	public List<PostEntity> getMyPostList(int userId) {
//		return postRepository.findAllByUserIdOrderByIdDesc(userId);
//	}

}
