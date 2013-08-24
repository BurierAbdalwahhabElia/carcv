#include <opencv2/core/core.hpp>

template <class V>
Mat vector2Mat1D(vector<V> vec) {
	Mat result;

	Mat_<V> templ = Mat_<V>(vec.size(),1);

	for(typename vector<V>::iterator i = vec.begin(); i != vec.end(); ++i) {
		templ << *i;
	}

	result = (templ);

	return result;
}

template <class V>
Mat vector2Mat2D(vector< vector<V> > vec) {
	Mat result;

	Mat_<V> templ = Mat_<V>(vec.at(0).size(),2); //todo: vec.at(0).size() remove this hack

	for(typename vector< vector<V> >::iterator i = vec.begin(); i != vec.end(); ++i) {
		for(typename vector<V>::iterator j = (*i).begin(); j != (*i).end(); ++j) {
			templ << *j;
		}
	}

	result = (templ);

	return result;
}
